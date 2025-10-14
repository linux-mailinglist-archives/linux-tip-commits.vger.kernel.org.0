Return-Path: <linux-tip-commits+bounces-6808-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 871E6BD9F91
	for <lists+linux-tip-commits@lfdr.de>; Tue, 14 Oct 2025 16:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 569463E3C4E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 14 Oct 2025 14:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A29265606;
	Tue, 14 Oct 2025 14:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mK+XKbGa"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF1326E6E5;
	Tue, 14 Oct 2025 14:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760451541; cv=none; b=htJafGjcmhbKO69t8E2TZGFf3vTPs8n9L+2XFQ2BC6yPvDWmTnk92lEZJwwaBbgSwVbaGoMzeykDEhMOXYcf6IV5ZbgVoUC5De6dPWmadf+15QMnmkMwrkiavX8lmI4tguUjvui0TV14kEa8xcu51CjkYYZ0qSfg4DcD6lYG7PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760451541; c=relaxed/simple;
	bh=zFvgiSA5zusH3E2W8KBAzMBZqLEN5paS14qc+yO4rlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HBcMVweMSz/zfa6vEc/rZt/cAhN2d2CRFQOzwIguexXlDmrsWvCxd0PAjpDsy3BPtZR1LqHIlmL3BXPXzig+2Gmkx5GH0EnFsiX6mq5/qqua2TtukQTwWCqqwqLJHNCxVFDs7VwmDNLR+QUz4fUkvzycGGpVP5+zYW+z2ZHid/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mK+XKbGa; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=zFvgiSA5zusH3E2W8KBAzMBZqLEN5paS14qc+yO4rlo=; b=mK+XKbGaLHq3d0/QUL2+M5dgX9
	foOOVBR7UFbS0Hb0BQewQEJMZhkzWgQoVD+haFNW5y4aB2AE8TWCgSOn6QTXTsOeFvBobeU7vUSHG
	t+Bt+AxsF+9UR6fNhcY+qQSPLQoOAYTewSbK4c81esrSKpjdBDA3kXgrscdatOS8bekEe9aTOFi5z
	tq/zidrwA98TNBCVYJppnQ/K56TFv6EfjuD53C+Na0Bo8f6KhvrXsdIxg2ixjUbLbyFt6A0ES3E+r
	tbQbuFgke0dAmILn4Bf1qDTre2zEcHcK9P9gpxL6HPPuMNwtpCvpTAste5mSEfR/pCbNSBUy1expZ
	HbWRsnWw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8frb-0000000CEhY-17nv;
	Tue, 14 Oct 2025 14:18:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 15CE1300212; Tue, 14 Oct 2025 16:18:56 +0200 (CEST)
Date: Tue, 14 Oct 2025 16:18:56 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>
Cc: Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
	linux-tip-commits@vger.kernel.org, x86@kernel.org
Subject: Re: [tip: x86/core] x86/alternative: Patch a single alternative
 location only once
Message-ID: <20251014141856.GA3245006@noisy.programming.kicks-ass.net>
References: <20250929112947.27267-4-jgross@suse.com>
 <176043135449.709179.18067035380831847643.tip-bot2@tip-bot2>
 <20251014125909.GAaO5JHU_cgsPgstc_@fat_crate.local>
 <20251014132544.GBaO5PWEbKfbQFCXdB@fat_crate.local>
 <ddb38d36-0194-414c-8614-1f37b1f38283@suse.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ddb38d36-0194-414c-8614-1f37b1f38283@suse.com>

On Tue, Oct 14, 2025 at 04:13:11PM +0200, J=FCrgen Gro=DF wrote:

> Could take some time, vacation is coming up...

Enjoy! This patch has meanwhile gone away.

