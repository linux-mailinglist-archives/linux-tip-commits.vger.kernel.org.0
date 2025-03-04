Return-Path: <linux-tip-commits+bounces-3994-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1B6A4EE15
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 21:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06891188ACD8
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 20:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1564323643E;
	Tue,  4 Mar 2025 20:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Do8OkoEG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17C11FA243;
	Tue,  4 Mar 2025 20:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741118979; cv=none; b=FRB8amMRDwM8DLu5g30UQWCeKIp9gGLlovscF6BxkgD8L83a7IUn4V7sDgYsQLwzIc+0zOxcEZTTzZ+3RITjbWLNeXCmH2ZONBno5whcsax10cjW3LQKFhtQWNisst2FYnHi+8I0gBJNkYBD/m1gwY8oEipqhtiDXpzXzCb0fMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741118979; c=relaxed/simple;
	bh=syPZePqkKm6KgonKlk/TzNBYlaEzdd8AmeS9Z/Ipw8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Watd67B2Gfk+4EeNHdqZwqrrB3hvyd0W/NaVlFQz027P0fPkS5dWPUTDOClrZjuQDFHsXJ47Q22tuT8/zgDca7lgHH6iCt+k6BA4HpwxhLFjKLYBxIBuE9ekNmZ0sm6OroVqx3++y56Q538Gpvc6YqBnNVZ8w7yXwehJTEIL1ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Do8OkoEG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 345CEC4CEE5;
	Tue,  4 Mar 2025 20:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741118978;
	bh=syPZePqkKm6KgonKlk/TzNBYlaEzdd8AmeS9Z/Ipw8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Do8OkoEGatl3+XRGasLUTWOLvc068DD1kZb2bdI/bSN6CUWq/1eW+3OeD76OWLoyu
	 /RkDbIqKoXPILF5KZ5FAyyY8AlH7kOa1yJi0s1nCYT4wc/euKYhtbturEc9AmmMlYB
	 bK0EsJ25BXD0aaIYsXPdj2SRiQBB4HtOrl1efdXJIwa8q5P/TQWCExB+/VpQfs4dG6
	 WOiLJqz9VM9jbnEGsOFAvvnNUSyI8QFD1lGZPF+gnH7yEKLo7B3vPirV9DMLvaKQaO
	 LUvCZy83HnzBDaHou8+lAp8lnYjlXAolzb5IA+ZIf1ibm2isJariM5cJd8OxHHoEjg
	 H69c0cL7MCbQw==
Date: Tue, 4 Mar 2025 12:09:35 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
	linux-tip-commits@vger.kernel.org,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Brian Gerst <brgerst@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org
Subject: Re: [tip: x86/asm] x86/asm: Make ASM_CALL_CONSTRAINT conditional on
 frame pointers
Message-ID: <20250304200935.wheet2xouue54bbv@jpoimboe>
References: <174099976188.10177.7153571701278544000.tip-bot2@tip-bot2>
 <CAHk-=wjSwqJhvzAT-=AY88+7QmN=U0A121cGr286ZpuNdC+yaw@mail.gmail.com>
 <Z8a66_DbMbP-V5mi@gmail.com>
 <CAHk-=wjRsMfndBGLZzkq7DOU7JOVZLsUaXnfjFvOcEw_Kd6h5g@mail.gmail.com>
 <CAHk-=wjc8jnsOkLq1YfmM0eQqceyTunLEcfpXcm1EBhCDaLLgg@mail.gmail.com>
 <20250304182132.fcn62i4ry5ndli7l@jpoimboe>
 <CAHk-=wjgGD1p2bOCOeTjikNKmyDJ9zH8Fxiv5A+ts3JYacD3fA@mail.gmail.com>
 <CAHk-=whqPZjtH6VwLT3vL5-b3ONL2F83yEzxMMco+uFXe8CdKg@mail.gmail.com>
 <20250304195625.qcxvtv63fqqk6fx4@jpoimboe>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250304195625.qcxvtv63fqqk6fx4@jpoimboe>

On Tue, Mar 04, 2025 at 11:56:27AM -0800, Josh Poimboeuf wrote:
> On Tue, Mar 04, 2025 at 08:57:13AM -1000, Linus Torvalds wrote:
> > On Tue, 4 Mar 2025 at 08:48, Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > Random ugly code, untested, special versions for different config options.
> > >
> > > __builtin_frame_address() is much more complex than just the old "use
> > > a register variable".
> > 
> > On the gcc bugzilla that hpa opened, I also note that Pinski said that
> > the __builtin_frame_address() is likely to just work by accident.
> > 
> > Exactly like the %rsp case.
> 
> Right, so they're equally horrible in that sense.
> 
> > I'd be much more inclined to look for whether marking the asm
> > 'volatile' would be a more reliable model. Or adding a memory clobber
> > or similar.
> 
> Believe me, I've tried those and they don't work.
> 
> > Those kinds of solutions would also hopefully not need different
> > sequences for different config options. Because
> > __builtin_frame_address() really *is* fundamentally fragile, and the
> > fact that frame pointers change behavior is a pretty big symptom of
> > that fragility.
> 
> While that may be theoretically true, the reality is that it produces
> better code for Clang.

BTW.  I confirmed that even the current version of ASM_CALL_CONSTRAINT
affects code generation for non-frame-pointer builds.

No matter what the ASM_CALL_CONSTRAINT implementation looks like, we
really don't want it affecting code generation for the ORC case.

So making ASM_CALL_CONSTRAINT empty for CONFIG_UNWINDER_ORC is a good
thing for code generation, regardless of the ASM_CALL_CONSTRAINT
implementation.

-- 
Josh

