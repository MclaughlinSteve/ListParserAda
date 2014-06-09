--Steve McLaughlin 
--Ada homework

with Ada.Text_IO, Ada.Integer_Text_IO;
use Ada.Text_IO, Ada.Integer_Text_IO;

procedure workers is
	type WorkerArray is array(1..26, 1..4) of character;
	type ShiftArray is array(1..4, 1..4) of character;
	Shift: ShiftArray;
	Workers: WorkerArray;
	Delimiter: character;
	numWorkers: Integer;	
	counter: Integer;

	procedure getshift is --This procedure gets the proposed list of shifts
	begin
		put_line("Enter proposed shift");
		counter:= 1;
		
		--Loop to add proposed shifts to array of shifts
		while counter <= 4 loop
			get(Shift(counter, 1));
			get(Delimiter);
			get(Shift(counter, 2));
			get(Delimiter);
			get(Shift(counter, 3));
			get(Delimiter);
			get(Shift(counter, 4));
			counter:= counter + 1;
		end loop;

	end getshift;

	procedure getinfo is --This procedure gets the number of employees and their names and skills
	begin
		-- Get number of employees and employee info.. May need its own function
		put_line("Enter number of employees");
		get(numWorkers);
		
		--Loop to add values to two-dimensional array which corresponds to workers and their skills
		counter := 1;
		while counter <= numWorkers loop
			get(Workers(counter, 1));
			get(Delimiter);
			get(Workers(counter, 2));
			get(Delimiter);
			get(Workers(counter, 3));
			get(Delimiter);
			get(Workers(counter, 4));
			counter:= counter + 1;
		end loop;	
	
	end getinfo;

	procedure echo is --This procedure echos all the information that was put into the program
	begin
		
		counter:= 1;
		new_line;
		--Loop to echo back proposed shifts
		while counter <= 4 loop
			put(Shift(counter, 1));
			put(Delimiter);
			put(Shift(counter, 2));
			put(Delimiter);
			put(Shift(counter, 3));
			put(Delimiter);
			put(Shift(counter, 4));
			new_line;
			counter:= counter + 1;
		end loop;
		put(numWorkers); --Echo, There is a weird space prior to printing this value.
		-- Loop to display the array of workers and their skills
		counter :=1;
		new_line;
		while counter <= numWorkers loop
			put(Workers(counter, 1));
			put(Delimiter);
			put(Workers(counter, 2));
			put(Delimiter);
			put(Workers(counter, 3));
			put(Delimiter);
			put(Workers(counter, 4));
			new_line;
			counter:= counter +1;
		end loop;
	end echo;

	function canwork(Shift: in ShiftArray;
		Workers: in WorkerArray)
		return Boolean is -- returns true if the person can do the job assigned to them, false otherwise
		isable: Boolean:= true;
		icounter: integer :=1;
		jcounter: integer :=1;
		kcounter: integer :=1;
		tempval: character;
	begin
		
		while icounter <=4 and isable loop
			jcounter := 1;
			while jcounter <=2 and isable loop
				tempval := Shift(icounter, jcounter);
				kcounter:=1;
				while kcounter <= numWorkers loop
					if tempval = Workers(kcounter, 1) then
						if Workers(kcounter, 2) = '1' then
							kcounter := numWorkers + 1;
						else 
							isable := false;
						end if;
					end if;
					kcounter := kcounter + 1;
				end loop;
			jcounter := jcounter + 1;
			end loop;
		icounter:= icounter + 1;
		end loop;

		if isable then
			icounter:=1;
			while icounter <= 4 and isable loop
				tempval := Shift(icounter, 3);
				jcounter := 1;
				while jcounter <= numWorkers loop
					if tempval = Workers(jcounter, 1) then
						if Workers(jcounter, 3) = '1' then
							jcounter := numWorkers + 1;
						else
							isable := false;
						end if;
					end if;
				jcounter := jcounter + 1;
				end loop;
			icounter := icounter + 1;
			end loop;
		end if;

		if isable then
			icounter := 1;
			while icounter <= 4 and isable loop
				tempval := Shift(icounter, 4);
				jcounter := 1;
				while jcounter <= numWorkers loop
					if tempval = Workers(jcounter, 1) then
						if Workers(jcounter, 4) = '1' then
							jcounter := numWorkers + 1;
						else
							isable := false;
						end if;
					end if;
				jcounter := jcounter + 1;
				end loop;
			icounter := icounter + 1;
			end loop;
		end if;


		return isable;
	end canwork;

	function shiftsokay(Shift: in ShiftArray) -- Returns true if no employee is scheduled twice
		return Boolean is -- returns true if shifts are okay
		isokay: Boolean:= true;
		type tempArray is array(1..16) of character;
		temp: tempArray;--Create an array to check for duplicates
		icounter: integer := 1;
		jcounter: integer := 2;
		kcounter: integer;
		tempval: character;
	begin
		counter:=2;
		temp(1) := Shift(1, 1);
		while icounter <= 4 and isokay loop
			while jcounter <= 4 and isokay loop
				tempval := Shift(icounter , jcounter);
				kcounter:=1;
				while kcounter < counter and isokay loop
					if tempval = temp(kcounter) then
						isokay := false;
					end if;
					kcounter := kcounter + 1;
				end loop;
				if isokay then
					temp(counter) := tempval;
					counter := counter + 1;
				end if;
				jcounter := jcounter + 1;		
					
			end loop;
			jcounter := 1;
			icounter := icounter + 1;
		end loop;

		return isokay;
	end shiftsokay;

begin 
	getshift;
	getinfo;
	echo;
	if shiftsokay(Shift) and canwork(Shift, Workers) then
		put("Acceptable");
	else
		put("Not Acceptable");
	end if;

end workers;
