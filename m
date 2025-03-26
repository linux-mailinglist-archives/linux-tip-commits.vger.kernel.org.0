Return-Path: <linux-tip-commits+bounces-4563-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A3CA71588
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Mar 2025 12:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B189A188BF07
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Mar 2025 11:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B0220311;
	Wed, 26 Mar 2025 11:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rCuz3t0M"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8769D1D5CDD;
	Wed, 26 Mar 2025 11:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742987494; cv=none; b=FFshZA890Hd6MAkXYiyashgiZmpEt4QvlrQN0SgbIKCb3Dps5N7FHHtrau6m5XVhDsjoJbkz7wBqreVzPB6BhjHH1jQxDYzdvTF4Trvi1fdV0uAOAMBVg8tu21qBqaM92u52MT194uy7pH7MPZNlKHJYsIPWNwYzEQr5b++HHzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742987494; c=relaxed/simple;
	bh=87MHvrl+YOj6Eu0ubTsUyFme+L+LVnmn3Ojqp30CT3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZWUCe1PoZhTptdzr19i34u8Tcq1Lwu6TzR5Wu85s6kYF/j1tzeEZuBpXbN9C4qpmr7y87nQ9ncj2sJi1sakqS4BcjJ4J16b5GcGMExGbuMZxzdW0+HGqqMf0GyxJYcq1vUHgXK5LT/IMh4BLx4F5XjDJAlFMhYC9knR9zCh/5gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rCuz3t0M; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=87MHvrl+YOj6Eu0ubTsUyFme+L+LVnmn3Ojqp30CT3M=; b=rCuz3t0MjuJSLfDG9uXX8NeDxS
	2b86DYDfBkY2vpHqxwrkBtcR64dSJbsnKDVI17yRfIerD86WFtpaTvVq8rW2VcWSgf+KkRnASZxuR
	mGhjYBjlNixH0uziVxvtfKLL6kfD9XN8C86mqnPzo7G+LAvm0EJ2aOuGqYDVFOr/VDCRmr817w7KN
	CyhlbahiDBz9bAbsQq6RIym32TbxV8p8iAg2kDP6pE0/MsDD9GEzhYe1pztHR7lfkkDyXidduasRY
	r2ZZl+wQzHhFw8XudVZXmqLnKijmN3Q5V+Rf2tXz8m9UgYtf4PzW5bMDT4n8F7P+c5e+5GWenK73l
	bzSidnBA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txOfS-0000000HQvD-0tlX;
	Wed, 26 Mar 2025 11:11:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CD3993003C4; Wed, 26 Mar 2025 12:11:29 +0100 (CET)
Date: Wed, 26 Mar 2025 12:11:29 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	linux-tip-commits@vger.kernel.org, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org
Subject: Re: [tip: objtool/urgent] objtool, pwm: mediatek: Prevent
 theoretical divide-by-zero in pwm_mediatek_config()
Message-ID: <20250326111129.GC5880@noisy.programming.kicks-ass.net>
References: <fb56444939325cc173e752ba199abd7aeae3bf12.1742852847.git.jpoimboe@kernel.org>
 <174289169184.14745.2432058307739232322.tip-bot2@tip-bot2>
 <4avdt2nru6cpypssyw5chxiuadh74qcobfboopwsske2ycr565@qnb6utlyxuj4>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7tfg6nBs+W9DQVTr"
Content-Disposition: inline
In-Reply-To: <4avdt2nru6cpypssyw5chxiuadh74qcobfboopwsske2ycr565@qnb6utlyxuj4>


--7tfg6nBs+W9DQVTr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 11:35:28AM +0100, Uwe Kleine-K=F6nig wrote:

> and the build works fine for me and there is no warning about
> drivers/pwm/pwm-mediatek.o. What am I missing?

Could be compiler related; IIRC it is mostly clang that does this. When
it finds /0 it simply stops code-gen.

I *really* dislike this behaviour, but since C declares this UB, they're
basically free to do whatever.

IMO it should just emit the code; kernel has exceptions to deal with
this and userspace gets signals.

--7tfg6nBs+W9DQVTr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEv3OU3/byMaA0LqWJdkfhpEvA5LoFAmfj4NsACgkQdkfhpEvA
5Lpr+w/+MhHhFk1YjgRMumD+rUIqcpnGodIaU0wrRdEFCYBsSg7Omijp6BbTbPtl
vcKTCihEurR+dzHONMvD5qf1l6LSTstAarJPu7YINArGBJgH8nj7vmEEDce1vXo3
eA4qGHBdAEMGCmtz9AEOv6yMNMHZ0SXyUaGBJgg/BiUjrxwukUnP5Y/TrvdQU7mi
XBHE+sM4CVzenovqFm/TlcpKbVdsFFeo9fykV/Fn0/BRqyoovGwrYMcb0Jx7BksH
n8ZWx5hqZbpCL9lFQjsM9tpV0mukPsaFHuYpEce8WoGNlZdqgttYWtGkWYPfav4X
3DL+aAlw5bKluDaMPM2/uBcsW+ilJFnCWL4VM1DRDlPMM6PXyStl3PLQynsnPOWe
mdhHNQO45aURJg7qcWZ1kpACcCG6ToPWlwvb8SX6EwHYscSO22SRKBACo5ETgaJF
5W0a+JUJ11CBh4kO8HsuMVnL7Dja+ugpq9oGSLbLhDio8vOfXBe4OvP18YkfWfUX
i521nmobOaWVnnolIyS/G+8Ek3XKvoumt0Y46wPYZs0g3M9rjF122jDykRFpUELr
5QesNoqNgldIUHtdQO+oeXsNujVskSjAjE+Q1y5GeQD4fMsn45kpzGwr7u8Mpxju
ZzI8csg6Y4ve0TkSeg5+U8LfTIiGMr8/d+fy5CcRf6AlATdn8mQ=
=6M7W
-----END PGP SIGNATURE-----

--7tfg6nBs+W9DQVTr--

