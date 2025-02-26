Return-Path: <linux-tip-commits+bounces-3628-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9B2A45364
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 03:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4B37189DD03
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 02:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C17C19DF40;
	Wed, 26 Feb 2025 02:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XCzviblH"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290D33FB0E;
	Wed, 26 Feb 2025 02:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740537926; cv=none; b=J8kcAVKvLCu1Ot9F7Kvfpx5TNwMo1Zaz/JpoDZuEXUm7Z5zlyV85usKIiSk0cZY1yFoPVXKuW2f3OWmSVCuqEuv7vS+4iqFo+oHVqrYqdry0P0qQOwlYrCl6IqAavtPqgq7aTLNoAc62QU0HGdydMKjas5rukwjoM5q4y3my+CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740537926; c=relaxed/simple;
	bh=uYMMZXMmXuEmXF+mt2VzXpg5mqrpTp80IRJvj1y0p68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lnpQNMvZmbwOI9e25y8CCjAJ7PnX1bBd0uTagN8vmURDKFHh6uLTgCy+4HaUbTJj2grNiuIJ93QKqdwZMkDQUxBUSWJML+fioFwWptEQynAlIZ2EqVS5WW8YYcDINj5/TbD7qTSyXVjXf00unHv52xyyy/D0jnnWeAA+308zlg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XCzviblH; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6RwGAOPkxr9NfsXVfI3sYKQyWxyJfmW9afLmo9FB8L0=; b=XCzviblHCpZasiqUlLzleRu1H4
	BdG31/ftNsKOK9HxMmulkg3wFD7yHrKYgBPcw7NdSSl62pkxPcWK3AWqcRzsTrftOXfmpG31Uvy0k
	hBmiR4TEBGGlBj93F08A+aJBReKnlnB6LxaG5FChiFofqZ4jWfKRTDLvS6CLP3NoWuKkLr6zMG/Ys
	avLzjtGVbjywyE/fEvHEltHtx3yS6lth4v2XfnJdFd7nts7Q3AZqfoWpxNs57+V3iE4Q44Po8wJ9n
	hM29l2h4LWcGHEFF1SJFljA4+3V1DDK4kD6lQk+e9qTa867QAKsItWQHA/lFCjXV0cA6kFEWxfw2I
	5IN5fweQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tn7QE-0000000DbNB-3trN;
	Wed, 26 Feb 2025 02:45:19 +0000
Date: Wed, 26 Feb 2025 02:45:18 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	kernel test robot <oliver.sang@intel.com>,
	Ingo Molnar <mingo@kernel.org>, x86@kernel.org
Subject: Re: [tip: x86/mm] x86/mm: Clear _PAGE_DIRTY when we clear _PAGE_RW
Message-ID: <Z76APkysrjgHjgR2@casper.infradead.org>
References: <174051422675.10177.13226545170101706336.tip-bot2@tip-bot2>
 <CAHk-=whfkWMkQOVMCxqcJ6+GWdSZTLcyDUmSRCVHV4BtbwDrHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whfkWMkQOVMCxqcJ6+GWdSZTLcyDUmSRCVHV4BtbwDrHA@mail.gmail.com>

On Tue, Feb 25, 2025 at 01:07:08PM -0800, Linus Torvalds wrote:
> On Tue, 25 Feb 2025 at 12:10, tip-bot2 for Matthew Wilcox (Oracle)
> <tip-bot2@linutronix.de> wrote:
> >
> > We should, therefore, clear the _PAGE_DIRTY bit whenever we clear
> > _PAGE_RW.  I opted to do it in the callers in case we want to use
> > __change_page_attr() to create shadow stacks inside the kernel at some
> > point in the future.  Arguably, we might also want to clear _PAGE_ACCESSED
> > here.
> 
> This explanation makes ZERO sense, and screams "this is a major bug" to me.
> 
> If a page is dirty, it doesn't magically turn clean just because it
> becomes read-only. The dirty data remains and may need to be written
> back to memory.

Are you saying that the PTE dirty bit controls whether the CPU flushes
cache back to memory?  That isn't how I understand CPUs to work.

> Imagine writing to a shared memory area, and then marking it all
> read-only after you're done. It's still dirty, even if it's read-only.
> 
> Now, I don't actually expect this patch to be wrong, I'm literally
> just complaining about the explanation. Because the explanation is
> very lacking. That's particularly true for the __set_pages_np() case
> which also clears _PAGE_PRESENT, because then the whole shadow stacks
> explanation flies right out the window: the shadow stack rules simply
> do NOT APPLY to non-present pte's in the first place.

Dave and I talked about that case.  We were concerned not that _this_
manipulation would lead to a shadow stack entry appearing (since the
present bit is being cleared), but that the next manipulation would just
set the present bit without setting the RW bit and we'd accidentally
end up with one.

> So honestly, I think this wants an explanation for why it's actually a
> safe change, and how the dirty bit has been saved before the
> operation.

I don't understand why the dirty bit needs to be saved.  At least in
the vfree() case, we're freeing the memory so any unflushed writes to
it may as well disappear.  But I don't know all the circumstances in
which these functions are called.

