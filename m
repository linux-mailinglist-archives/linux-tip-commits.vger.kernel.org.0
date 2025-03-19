Return-Path: <linux-tip-commits+bounces-4327-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 248CCA689D8
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 11:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24F8916BD77
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 10:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64175251785;
	Wed, 19 Mar 2025 10:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="MOVHj0Sx"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC5E2505B2;
	Wed, 19 Mar 2025 10:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742381001; cv=none; b=JMzY+rn4YBqQGyKKaHjfN7PvVDiVpcETYUXreHzhjmJyey+n21NmEBXzMcwXH/DB8L+XTx+hEScv0QqClR1+3z/vvPhO5ZGek85z0EF3h+UbQmwoArUUjoe4tFmXWrLDtlUmrp2yLy20tZlJDtHgCOOb+4OeXJN6oRnzmdjzyxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742381001; c=relaxed/simple;
	bh=ObEc317LF7jwRjplVGFRXZTgT/lSDCp6G8Axwyc6Qoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gLJDZBK7HRDIbNvGhHtNEg7OgrQcLQOFeLMmMJuWNg+hFqJZ4u8DtIj101JRzbCKNZkGbesoyWQrZokAcks3d369vSvxyzZkk2NHx8le818A3nu2BMm1Qzu8E5//IMAZv4yR272twxrSAH+uFhggefs/m5KG+UtenFpF4m7cKDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=MOVHj0Sx; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7758840E015E;
	Wed, 19 Mar 2025 10:43:17 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 8iI48c0pKZgw; Wed, 19 Mar 2025 10:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1742380994; bh=uJDMZ6psRv09REULj/mJyDEnXA8mipBsiHNzg5hff1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MOVHj0SxvaCsrlTI6jIQZ1pTZkBtETeejiPyWD3DgmDWB76hKlC4kTbgYm0XrmFbA
	 9JoiXM7sDbILFn6IbhRLQAskOnBKmFt+VUGUDnAg1V49ZM+a1+xlSqbf1q8bhvgbm3
	 8rtMzNwJ9IFu9OgZDi8p8PVPlKQv39zBUHIiIwYFidsEDyLpM3HqcezmYxLdZChu6i
	 UYINPmPIcmNMIKnAzDI/dpvL9PPlNGtf8MlgcSPKS7k/tFIxZGZ3w3Paxnh9UIicyL
	 3AKdJzsh0gP3sMLivnJHafeeYnBrOsHfIeeFY1VQFdl9TD9aeT3BwLGAljXMkonv75
	 buCOmClvGCGaV87KfqTMh7Wps9fssHXInA+jsC59N1B7FP4ZoCFOwcx3BZWKEcRe2o
	 K12YbLDawSZN/aMRAIorC0NM+Evfx6Ovbp2QntC1qizIbHo7xL+NbE9zcNINfxqr70
	 mHa7GrvHaGsIM+PkaMGIdeBWQS1fLV64ERpnFxNr76B8uIXbJvntanpYkXI+7/yAbQ
	 w4kv7JM+9dj0l6KSJTYVNF1ABzvt1Sfog/ZBtHeVL1LLze+a9X9iB3R+Ccux11CZ2C
	 kCLGff1eJs6WsL04wS2mNnhKmI2uqSBxe74q48UmpCjk8JlVgp5tgF1BdWq3dM5akF
	 Xcc5kBWeoUMihLBhOHjLr/tw=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 046A640E016E;
	Wed, 19 Mar 2025 10:42:56 +0000 (UTC)
Date: Wed, 19 Mar 2025 11:42:56 +0100
From: Borislav Petkov <bp@alien8.de>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	xingwei lee <xrivendell7@gmail.com>,
	yuxin wang <wang1315768607@163.com>,
	Marius Fleischer <fleischermarius@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Rik van Riel <riel@surriel.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Peter Xu <peterx@redhat.com>, x86@kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [tip: x86/mm] x86/mm/pat: Fix VM_PAT handling when fork() fails
 in copy_page_range()
Message-ID: <20250319104256.GCZ9qfsCKuBqDU3Oyv@fat_crate.local>
References: <20241029210331.1339581-1-david@redhat.com>
 <174100624258.10177.4534865061014070904.tip-bot2@tip-bot2>
 <fe0a67dc-d7cb-42ff-9b20-9527af7f6a94@redhat.com>
 <20250319095357.GAZ9qUNaWSORZMXdRK@fat_crate.local>
 <50f03347-0586-4284-b02d-b16abf89e656@redhat.com>
 <20250319102441.GBZ9qbaZfRWdYFIknU@fat_crate.local>
 <faa04276-a4d7-48af-8957-9123cc09f66b@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <faa04276-a4d7-48af-8957-9123cc09f66b@redhat.com>

On Wed, Mar 19, 2025 at 11:27:19AM +0100, David Hildenbrand wrote:
> Yes, expect it later today

Thanks!

> -- have to refresh my brain how I managed to reproduce the original issue.

Tell me about it. :-\

I have a big fat mostly enlarging and seldom collapsing text file called
todo.txt.

:-P

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

