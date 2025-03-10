Return-Path: <linux-tip-commits+bounces-4111-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C29A59A9C
	for <lists+linux-tip-commits@lfdr.de>; Mon, 10 Mar 2025 17:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE9F5164EBD
	for <lists+linux-tip-commits@lfdr.de>; Mon, 10 Mar 2025 16:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E801522B8AC;
	Mon, 10 Mar 2025 16:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jxlOAaad"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6244A22FAE2;
	Mon, 10 Mar 2025 16:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741622691; cv=none; b=aVt7cW3WD1KQVhtrCgz962NXVRnMBrTnJQ24LQDYYoyRo5IKNWixCXqfoUDA+uAGh1x3a3AZh5yfKe45BFqbdOPS9/jeEa22XdREutsoJuVg4i4bjVoZ25CjcEZ42RaYlritY3XjDs0pz5WOQrJLsvk8H/fP/SjwCNlfpfuDuKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741622691; c=relaxed/simple;
	bh=ok47zFOikALBSPe6RtUpjW0RG1UjXTx0V15XKemJDaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fbyTurw6vGjdl5fWpQWDX1I1hiL7extyec86ZEtrdPan2fxiW7IraLjUjIrs+l13VP1Xw9iFbs2+hnY+cOzDn6TaEXC6e8Sp1zIWQ9LM5yTC4DcO5UGGSovbs3YackJM9crMhUkGg06/k9OTlmzYjEG9WFLEWoQOBduYU8RIZBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jxlOAaad; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=8WlVgPRyG8mlMTJa5phSr3A/Y+TwfOvi6DaaaR8Ypqg=; b=jxlOAaad7CjCHbr/K6M6H9MJeP
	MUsnMUv3QbqtRTYvPaYcj2vK2hIPP1XI9EBuNN3mdoDZCmIt1U9ENZugokpkdZM9vW0846iAQsPK+
	eEcJrpoxaF6B3hwEixyeJYz10CggZ2OF6V7kwuOERzboTZE5lcQ/gHVPjiTzls0E+3wG6EXg1elg9
	u4jXlVTvje7BT1DzFH3hnZ7q/+rTG8uKJYQVHLXfj0+1GiO54mnr/eQlHFG7lK9TS4asPOHCNxFIn
	b9rrBCL5iAWUhhuU9Fi9ZGQA9CGgr1NAtkG9562+ospNlVx0zPyYqZiizcJZJpQnfAxRhbDVN5htd
	JyUY8qMQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1trfcV-00000001uWA-0zbh;
	Mon, 10 Mar 2025 16:04:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 915DF300599; Mon, 10 Mar 2025 17:02:42 +0100 (CET)
Date: Mon, 10 Mar 2025 17:02:42 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Ramon de C Valle <rcvalle@google.com>,
	Matthew Maurer <mmaurer@google.com>, linux-kernel@vger.kernel.org,
	ojeda@kernel.org, linux-tip-commits@vger.kernel.org,
	Scott Constable <scott.d.constable@intel.com>,
	Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>,
	x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>,
	Alice Ryhl <aliceryhl@google.com>
Subject: Re: [tip: x86/core] x86/ibt: Implement FineIBT-BHI mitigation
Message-ID: <20250310160242.GH19344@noisy.programming.kicks-ass.net>
References: <20250224124200.820402212@infradead.org>
 <174057447519.10177.9447726208823079202.tip-bot2@tip-bot2>
 <20250226195308.GA29387@noisy.programming.kicks-ass.net>
 <CANiq72=3ghFxy8E=AU9p+0imFxKr5iU3sd0hVUXed5BA+KjdNQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72=3ghFxy8E=AU9p+0imFxKr5iU3sd0hVUXed5BA+KjdNQ@mail.gmail.com>

On Mon, Mar 10, 2025 at 05:00:47PM +0100, Miguel Ojeda wrote:
> On Wed, Feb 26, 2025 at 8:53 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Feb 26, 2025 at 12:54:35PM -0000, tip-bot2 for Peter Zijlstra wrote:
> >
> > > +config CC_HAS_KCFI_ARITY
> > > +     def_bool $(cc-option,-fsanitize=kcfi -fsanitize-kcfi-arity)
> > > +     depends on CC_IS_CLANG && !RUST
> > > +
> >
> > Miguel, can we work on fixing that !RUST dep?
> 
> Thanks for the ping Peter -- we discussed `rustc` in the couple PRs
> that added it to LLVM back then, and I think the conclusion was that
> it shouldn't be a fundamental problem to add it to `rustc`.
> 
> From a quick look, the Clang flag that eventually landed just emits
> one more `llvm.module.flags` and LLVM takes care of the rest. So it
> should be straightforward to add a `-Csanitize-kcfi-arity` in `rustc`
> and then pass it at the same time to both Clang and `rustc` in the
> kernel.
> 
> But I may be missing something -- Cc'ing Ramon and Matthew, since they
> are the ones behind sanitizers and kCFI in upstream Rust.
> 
> I added it to our list, and created an issue in upstream Rust for it:
> 
>     https://github.com/rust-lang/rust/issues/138311
>     https://github.com/Rust-for-Linux/linux/issues/355
> 
> I will also mention it in the meeting with upstream Rust in a couple days.

Thanks!, let me know if there's anything I can do. I'm happy to test
patches.

