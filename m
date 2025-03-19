Return-Path: <linux-tip-commits+bounces-4402-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE05A69BC7
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 23:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1451316A076
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 22:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A16214227;
	Wed, 19 Mar 2025 22:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UBGHdm5l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41702147F5;
	Wed, 19 Mar 2025 22:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742422095; cv=none; b=IqSfveG/xiTFwYWn3vRDn0MPFe1/RA3IUgc6oXRzTWCYiqRNAgNhkPhzps/Mj9QudZ5w1mLYFlTG5qNx9IoQ4CCvc8k0sKIC18qpKrZnFybyKYHfLFnAhBanorHPpqEGVDTQMme7HNGznG8LghxnRb0K94w9t8zqSzATSVdwtQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742422095; c=relaxed/simple;
	bh=sxVspbPMCcDsBlN7bTTxJKQWXH5/LcvlVmUEH7ECVn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XNRQ9iRG6DeyOCPEdXzU2e9v43iHScewAD6oxWi0XHegXL5tL7ucomAY8ozcBwq5IOTiHWop59UCrWMtBN4bUNJCk7U8YIL/m6MSahVfbWGJpUcYYiNzZlScgtqhC1At8HVWBcTFSRe6hp7JZsBNXqTCeQLgx4Q9iRYNiQNub8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UBGHdm5l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B884C4CEE4;
	Wed, 19 Mar 2025 22:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742422095;
	bh=sxVspbPMCcDsBlN7bTTxJKQWXH5/LcvlVmUEH7ECVn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UBGHdm5lowxgLfgDB4wiPhpBWFBGRPcXI7dhjNYENxARIt3Vzay6bsg9Xyo9zv69X
	 CsR/mtN/7Q2mngkknN8boyYs2/oDENg1MKfbLjYyKZ0RQT3v84ChNOAgq1Z6KeJK1z
	 hoRca/63i/aLxD34e6HqzXzJqRuF1GfOrM0DiuFg44qCa9PrkyYSVJOCK/TzEc5cy/
	 yjvWASjjT5SI7qi8Cv1Ssnps2y04m7Dgfo+YWiUXr4isFnPh6I/xRswDMSk/AiPkfy
	 ZmcyR7ChcnnUT+oEkpFStWJ7EyBTQ7Va7+mhlNSjy1kkTGYT5CHFQFu9NINNyNkN/u
	 Peb6bNc6LVxwQ==
Date: Wed, 19 Mar 2025 23:08:08 +0100
From: Ingo Molnar <mingo@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	xingwei lee <xrivendell7@gmail.com>,
	yuxin wang <wang1315768607@163.com>,
	Marius Fleischer <fleischermarius@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Rik van Riel <riel@surriel.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Peter Xu <peterx@redhat.com>, x86@kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Borislav Petkov <bp@alien8.de>
Subject: Re: [tip: x86/mm] x86/mm/pat: Fix VM_PAT handling when fork() fails
 in copy_page_range()
Message-ID: <Z9tASMtphcvCvqsi@gmail.com>
References: <20241029210331.1339581-1-david@redhat.com>
 <174100624258.10177.4534865061014070904.tip-bot2@tip-bot2>
 <fe0a67dc-d7cb-42ff-9b20-9527af7f6a94@redhat.com>
 <Z9qkCQE9dsXdlsKn@gmail.com>
 <d767a3d4-b54a-4bdd-91d3-dc1de00637ec@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d767a3d4-b54a-4bdd-91d3-dc1de00637ec@redhat.com>


* David Hildenbrand <david@redhat.com> wrote:

> On 19.03.25 12:01, Ingo Molnar wrote:
> > 
> > * David Hildenbrand <david@redhat.com> wrote:
> > 
> > > > +void untrack_pfn_copy(struct vm_area_struct *dst_vma,
> > > > +		struct vm_area_struct *src_vma)
> > > > +{
> > > > +	resource_size_t paddr;
> > > > +	unsigned long size;
> > > > +
> > > > +	if (!(dst_vma->vm_flags & VM_PAT))
> > > > +		return;
> > > > +
> > > > +	/*
> > > > +	 * As the page tables might not have been copied yet, the PAT
> > > > +	 * information is obtained from the src VMA, just like during
> > > > +	 * track_pfn_copy().
> > > > +	 */
> > > > +	if (get_pat_info(src_vma, &paddr, NULL)) {
> > > > +		size = src_vma->vm_end - src_vma->vm_start;
> > > > +		free_pfn_range(paddr, size);
> > > >    	}
> > > 
> > > @Ingo, can you drop this patch for now?
> > 
> > Done.
> 
> I can resend the whole thing, or just the fixup suggested by Boris, just let
> me know.

Please do, thanks!

Thanks,

	Ingo

