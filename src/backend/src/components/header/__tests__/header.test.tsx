import React from 'react';
import { render, screen } from '@testing-library/react';
import Header from '..';

describe('Header', () => {
  it('renders the header', () => {
    render(<Header />);

    expect(screen.getByText('Capacity management')).toHaveAttribute('href', '/');
  });
});
