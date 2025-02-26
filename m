Return-Path: <linux-tip-commits+bounces-3630-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9449A4543F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 05:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F232188BB40
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 04:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C198D14387B;
	Wed, 26 Feb 2025 04:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PJEtCbWW"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2519B33DF;
	Wed, 26 Feb 2025 04:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740542449; cv=none; b=jBznl/DQl5JK6iWEcCy/egUbsb1lDI+qdHVBc0mGTTb6euHfd5zpgcn5R4rI71NGRpVLyHVy3b+pbhvuKzJ+NN/aNM6JLiOIKQIDpuMlbHl/agzE038W8SR+SwqggG1ZZsly+RGXuEEpI0KNatPf7DUtZYqgEWeCEWPDO9gOrEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740542449; c=relaxed/simple;
	bh=WuScmXdTnBOKhr8HRJmOnG3gODKtqA7a5/ra1ZNASMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MimapPncYcM30J0Haz0ESRYoWGOzsVpxPRAgsJlTKtu4VjqHXaAYiLWDjcUAZ4MathG/LvPooqYdRIs0VtO+iSQ/HhFD+SGySMUOXIVqm4nh/QgBtfKK/gRoUbF6ctX5Ee6e8RTdBOL/bDHMqH+3S7QWg9HLRO7n8vMRSDh4smo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PJEtCbWW; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sWA4IJ/vY4wf60+zufAFhmWxQoWGPyKYXXMI/1ohZiY=; b=PJEtCbWWdeG/jJzk8JKTpwxqT/
	pvpxbw79m2N2RJlxWbtTUpPmNx/2DcYw02cQ2Bv1c97KrusrmjTACcS/QAxS+SPM8JxHX7fl3byTm
	rY61QPX5HFD6De0yymukKyhqJYGX+lLKtwDjV7v4tKdUj07wDTgmppbSK0mK/XxGDg+bDZ4+IcW93
	8pieHYwNAUfijEKJVRv8ByavsCPdAPbTM73gzGLV9f5S5ZRDSq+1Kodg2EZKHZSIPyTBHAmckrk9e
	PVMyocrd9lCh6Z/zRp9Sl3EQZgjsV2f+ayw8Jr+LHN4GUzfJfkIW6CLWSPnmUrfAQ/5W4sG4jeeW8
	hXomD2KQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tn8bA-0000000DoXr-2Jt6;
	Wed, 26 Feb 2025 04:00:40 +0000
Date: Wed, 26 Feb 2025 04:00:40 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	kernel test robot <oliver.sang@intel.com>,
	Ingo Molnar <mingo@kernel.org>, x86@kernel.org
Subject: Re: [tip: x86/mm] x86/mm: Clear _PAGE_DIRTY when we clear _PAGE_RW
Message-ID: <Z76R6ESSwiYipQVn@casper.infradead.org>
References: <174051422675.10177.13226545170101706336.tip-bot2@tip-bot2>
 <CAHk-=whfkWMkQOVMCxqcJ6+GWdSZTLcyDUmSRCVHV4BtbwDrHA@mail.gmail.com>
 <Z76APkysrjgHjgR2@casper.infradead.org>
 <CAHk-=wj+VBV5kBMfXYNOb+aLt3WJqMKFT0wU=KaV3R12NvN5TA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj+VBV5kBMfXYNOb+aLt3WJqMKFT0wU=KaV3R12NvN5TA@mail.gmail.com>

On Tue, Feb 25, 2025 at 07:31:01PM -0800, Linus Torvalds wrote:
> > I don't understand why the dirty bit needs to be saved.  At least in
> > the vfree() case, we're freeing the memory so any unflushed writes to
> > it may as well disappear.  But I don't know all the circumstances in
> > which these functions are called.
> 
> I'm not saying that it needs to be saved.
> 
> But I *am* saying that it needs to be explained why dropping it is fine.
> 
> And I am also saying that your explanation for why it should be
> cleared makes no sense, since two out of three cases also cleared
> _PAGE_PRESENT, at which point the whole shadow stack issue is
> completely irrelevant.
> 
> So please explain *why* clearing PAGE_DIRTY is ok. Don't bring up
> issues like the shadow stack setting that is irrelevant for at least
> two of the cases that you changed.
> 
> If all of these are purely used for vmalloc() or direct mappings, then
> *that* is a valid explanation ("we don't care about dirty bits on
> kernel mappings"), for example.

I think the entire point of this file is to manipulate kernel mappings.

