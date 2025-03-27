Return-Path: <linux-tip-commits+bounces-4573-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEFBA7402F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Mar 2025 22:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFD78172B80
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Mar 2025 21:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEB21D47C7;
	Thu, 27 Mar 2025 21:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FIHMwYiI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2553D13DBA0;
	Thu, 27 Mar 2025 21:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743110516; cv=none; b=SzOtHNA9U7T4TcjFk9PLgaQEjS7bHFtURtMN8dm70kOhbFbn7IogrwvXPGl0xWHMviNKXUX+c+ODVSEsTvTvndKXgw9++Ym6NKdvSl2mtWZQFIF63HrHoX0ojwclsMPEm8t9sYsByuU5Npfc7Hmc5x64tBAS5tPLdgrVpoyUnNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743110516; c=relaxed/simple;
	bh=QQHFriYXKJo+p6mTq2x5pe8wMRPOd+HpVPpdKJJfJQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qnJBIXCiR/X1n6BafSMYmV49cwY5hK8kstHpTlYMGnfhlAqO9lY2m2PnbSn7jJfusWEdt99YuooH8/P4z7zUblvHFltP5gRALs2vI/nH6j9keSZGJUrVo+S7lVpwITz8Dqq2kJDxIHlTISpl84Kj9zez2n+WFmHFcJ5CqMgXLTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FIHMwYiI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26711C4CEDD;
	Thu, 27 Mar 2025 21:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743110515;
	bh=QQHFriYXKJo+p6mTq2x5pe8wMRPOd+HpVPpdKJJfJQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FIHMwYiI4KQfQ7DPAVlXGTWVRs55Ml09/yhleFNR5Dgg92bpDVo4ncNQZEbiZgG+T
	 AakosSxDSWtTmcbDzGIl8dZfAPJZluaWtvCfe7xQ6KmVxDbGbEOEJDoUuvcGocXpvw
	 NbeQyEdF3SXdNgvAHQZOL93hryJGfCzHI/RxHYdrzBma5K+ALTk3T3XZ7tBxjsbeHk
	 mAS4yNGye/uv0WB3dhoVGBb02fd7F3WG3Xnk1kzJnMmpey61vjLNsA//TXLsJVLWOp
	 UPirkArcvLI3UW1Y4a0a3IggW9XCS3qvtscNd3krQ5Ri9l2vXPnO+srtgbR47mxSk+
	 N/EPZ4n7AXQwQ==
Date: Thu, 27 Mar 2025 22:21:51 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, linux-tip-commits@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org
Subject: Re: [tip: objtool/urgent] objtool, pwm: mediatek: Prevent
 theoretical divide-by-zero in pwm_mediatek_config()
Message-ID: <Z-XBb_8f6cItnlZN@gmail.com>
References: <fb56444939325cc173e752ba199abd7aeae3bf12.1742852847.git.jpoimboe@kernel.org>
 <174289169184.14745.2432058307739232322.tip-bot2@tip-bot2>
 <m7pgkp3ueo7iqgqf74upjrihr3mpmb3sqhwegnjxxwsrgx2jsw@dnec5iqiyobh>
 <Z-Uv60sD_S2xYVB1@gmail.com>
 <nzk5uzpwqqkflmdgfe7kwsnsecqnsn6vsyo4ycoaueasnud6ot@pg6cazrf6zuf>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nzk5uzpwqqkflmdgfe7kwsnsecqnsn6vsyo4ycoaueasnud6ot@pg6cazrf6zuf>


* Uwe Kleine-König <ukleinek@kernel.org> wrote:

> > > > Cc: "Uwe Kleine-König" <ukleinek@kernel.org> (maintainer:PWM SUBSYSTEM)
> > > > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > > > Link: https://lore.kernel.org/r/fb56444939325cc173e752ba199abd7aeae3bf12.1742852847.git.jpoimboe@kernel.org
> > 
> > I've also tentatively added your Acked-by, if that's OK with you.
> 
> The patch is OK.

Thanks!

> [...] Iff you can convince me that it should go via tip, it's fine 
> for me.

I wanted to collect all the objtool fixes for CONFIG_OBJTOOL_WERROR=y 
failures in a single place to not inconvenience randconfig CI testing 
efforts, so in that sense it would be nice to send this via the 
objtool/urgent tree, but I'll remove it if you insist.

Thanks,

	Ingo

