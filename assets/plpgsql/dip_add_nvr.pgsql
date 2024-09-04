
코드 복사
CREATE OR REPLACE FUNCTION insert_cctv_items()
RETURNS void AS $$
BEGIN
    -- Insert 4 CCTV entries into dip_list_cctv
    INSERT INTO dip_list_cctv (name, status, addr) VALUES 
        ('CCTV_1', TRUE, '123 Street A'),
        ('CCTV_2', FALSE, '456 Street B'),
        ('CCTV_3', TRUE, '789 Street C'),
        ('CCTV_4', FALSE, '101 Street D');
END;
$$ LANGUAGE plpgsql;