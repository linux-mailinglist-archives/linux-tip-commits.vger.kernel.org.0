Return-Path: <linux-tip-commits+bounces-4127-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6237BA5D915
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 10:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 377911894C7F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 09:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE97238179;
	Wed, 12 Mar 2025 09:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cQyFGRQp"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7346022FF35;
	Wed, 12 Mar 2025 09:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741770999; cv=none; b=ZIyjBbAjpJYj9J01RdV7Cm3jDhnxvcmre17yfHejotRRHcc2FCWCNPGtg885Aa2Im4yv5+25ou6yp8Z0uaOcVeslDDi6nVgpHHg1gsJNuqJehGwlddEbi6pwydj8MQOlI7+Qd9+Pw4GT8sDHXOt1BNnQHHwTw+id1qNPoOwmLKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741770999; c=relaxed/simple;
	bh=s/m/3vOZyWA5Ev2YRSMVCybMw1FuS/WZtbR1ovRpVI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KFtO8S8ebJYLUd1Rjx3SdF4x2Qh3T3dijJ5CTxXpPmf6Nd7/83xL41DxPIanXmXVzboOAiMCfrq+0aB9ALTuyRBibe5ig+k9EU+bt9EMkbKxGIbTJhqN8pn7aa31NVWV62baoHex5eyhg8d7wTT3trvZjgM1itoIeH8yG8mjr8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cQyFGRQp; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=6+A1HD2y168nRPLvWEMVKwxYLgogdLxXeB0ZDGFNz98=; b=cQyFGRQpp/GGkyrHYcZ1O7au/d
	uPM2XH5F1Ol10VzaBx9DzeDUgUZmVEquM/5KFjynXkV33jzRRgCP/KX/ytt7P2hGxau0KP065imtl
	roEgnaGNPoe+oHL/zFMbdb5D4/rmrJf6o9P0oa/wl2l5/MbD8YA3X1XkRHFvLHLKq902TxwEBIpnl
	TEEQgJVy4hmRWI/CSvjYnL6GrEJa2VhPDfFp9ZtyY8tVbUU1YWSqJUHd6VQu6tEdx1Vo+EaFW+cJ9
	U5gvL0mYLFeNapT9VAsTD7iEQ66glg+fRuW+7qdQcu4oYrd8lyqMuDsvQejl4FsnZNoJrnkUwmbPC
	5/U49SJg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tsICY-0000000Ceue-0sV1;
	Wed, 12 Mar 2025 09:16:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9B1FF300599; Wed, 12 Mar 2025 10:16:33 +0100 (CET)
Date: Wed, 12 Mar 2025 10:16:33 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ramon de C Valle <rcvalle@google.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Matthew Maurer <mmaurer@google.com>, linux-kernel@vger.kernel.org,
	ojeda@kernel.org, linux-tip-commits@vger.kernel.org,
	Scott Constable <scott.d.constable@intel.com>,
	Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>,
	x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>,
	Alice Ryhl <aliceryhl@google.com>
Subject: Re: [tip: x86/core] x86/ibt: Implement FineIBT-BHI mitigation
Message-ID: <20250312091633.GI19424@noisy.programming.kicks-ass.net>
References: <20250224124200.820402212@infradead.org>
 <174057447519.10177.9447726208823079202.tip-bot2@tip-bot2>
 <20250226195308.GA29387@noisy.programming.kicks-ass.net>
 <CANiq72=3ghFxy8E=AU9p+0imFxKr5iU3sd0hVUXed5BA+KjdNQ@mail.gmail.com>
 <20250310160242.GH19344@noisy.programming.kicks-ass.net>
 <CAOcBZOSPBsTvWFdpwE0-ZU76yMDGBEo3p9y614XYEu+ZSnQ6Sg@mail.gmail.com>
 <CANiq72mcCEbeWb-RAXLcWRnJms2LA6xV=QqQ5=N3ii=3TC89fw@mail.gmail.com>
 <CAOcBZOQnGCqKut-BTvfJNgB9Rz+f5DAANwMs9DU16Js+QDGOrw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOcBZOQnGCqKut-BTvfJNgB9Rz+f5DAANwMs9DU16Js+QDGOrw@mail.gmail.com>

On Tue, Mar 11, 2025 at 01:23:39PM -0700, Ramon de C Valle wrote:
> On Tue, Mar 11, 2025 at 12:41 PM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > On Tue, Mar 11, 2025 at 8:09 PM Ramon de C Valle <rcvalle@google.com> wrote:
> > >
> > > I've submitted a PR for it:
> > > https://github.com/rust-lang/rust/pull/138368. Let me know if you're
> > > able to give it a try.
> >
> > Thanks Ramon, that was quick!
> >
> > Left a comment there and linked it -- if you meant to ask Peter, then
> > I guess it would be easiest for him to use the first nightly that has
> > it as a `-Z` flag.
> >
> > i.e. I think it is simple enough to land it as-is, especially if we
> > add the quick check I suggested.
> 
> Left a note there. Let me know what you think. Yes, I guess we could
> just check the next nightly that has those changes.

The rust-log-analyzer seems to suggest the nightly build failed?

Suppose it didn't fail, where do I find it? 

I normally build llvm toolchains using tc-build, but it seems rust is
not actually part of llvm?

