import React from 'react';
import { Header as NhsHeader } from "nhsuk-react-components";
import './styles.css';

const Header: React.FC = () => {
  return (
    <NhsHeader>
      <NhsHeader.Container className='pull-left'>
        <NhsHeader.Logo href="/" alt='Home Page' />
        <NhsHeader.ServiceName href="/">Capacity management</NhsHeader.ServiceName>
      </NhsHeader.Container>
    </NhsHeader>
  );
}

export default Header;
