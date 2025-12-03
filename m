Return-Path: <linux-tip-commits+bounces-7582-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B069CCA12F3
	for <lists+linux-tip-commits@lfdr.de>; Wed, 03 Dec 2025 19:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC46B3176985
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Dec 2025 18:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822B3328634;
	Wed,  3 Dec 2025 17:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzvuxx2L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5943F325735;
	Wed,  3 Dec 2025 17:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764782434; cv=none; b=qsSkKiLP/+eIG+6WurB0FfINZHImgPOHxyZAJvxhdfvQq0gs8KZiBBiOpGEZ1kqE8OoHs3WEyTYY4VS6OE3PDTHx6b4V1DowaNlzIunstOlfqTuGRaPZsSG0QnH2bgAFv9WxPh5HuNhj5aXzHyFP+lHG/zQIn8s/+0FLVmUJDjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764782434; c=relaxed/simple;
	bh=K6jsKFeUSyJ29dTTNBMBRTbJoEG44Vm6ujM80FBbrkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PQgR1SL7jTjfdfFlpKqW5ac78JAiVh5Ou7Qv9nRP1YUax+m1vKv0QSevlLQhOlBvhdqd8/4y23BCU5VdYRp4AGi+FeJ+KGjwJ/YIxc2sm5VvnoBSK7EoNXhOWB3IbT4eqi9LIoFHuzSGXqnrjQ8WsfR2n06fnVLVQyg5NwqGTok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzvuxx2L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 201B0C4CEF5;
	Wed,  3 Dec 2025 17:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764782433;
	bh=K6jsKFeUSyJ29dTTNBMBRTbJoEG44Vm6ujM80FBbrkk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hzvuxx2LqPO5PxYE9UhQg2sjthzV0VJq4EdlBkfWsCbs7IfqoAERnB6epH8Cv/Ngj
	 HZzzMJo1uqrbEPbPLqT9BPNuNQtuSAm5BsQA7l/ZU2JFXZGo+YcUdR6FSQRiULN6ki
	 CiEucVOtCbE4qDhdbSfBv0c6BNO1vPPXp/pXOD5kAzKz+gbdtaclaBJaAk+m/Z59i/
	 fVXxpYbHErBRBBvx+uWitkm/ejdSgZ1h3LO9yYCNu8u68f4NHRUcI5w/xOow97xlwf
	 UfHiYZAqZnfZepsomvB3kcZqdExiT5nLNEvZVU2EilwksgGS0lF2u1PhWSogWP4UjP
	 GjzBekvxAKN9Q==
Date: Wed, 3 Dec 2025 09:20:31 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org, x86@kernel.org
Subject: Re: [tip: objtool/urgent] objtool: Consolidate annotation macros
Message-ID: <q42ky23vrxcyaefudecra3otbcq27kekmrwbjrtqmwsloqwuom@o6xw37uul4e7>
References: <c05ff40d3383e85c3b59018ef0b3c7aaf993a60d.1764694625.git.jpoimboe@kernel.org>
 <176478003405.498.13298696533128884255.tip-bot2@tip-bot2>
 <CAHk-=wgzL-bCggZOuDU7_f-1jpjus8Oaqtek9T8GdGUexnHYkg@mail.gmail.com>
 <aTBr3ImmrJQe4G49@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aTBr3ImmrJQe4G49@gmail.com>

On Wed, Dec 03, 2025 at 05:57:00PM +0100, Ingo Molnar wrote:
> * Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > On Wed, 3 Dec 2025 at 08:40, tip-bot2 for Josh Poimboeuf
> > <tip-bot2@linutronix.de> wrote:
> > >
> > > Consolidate __ASM_ANNOTATE into a single macro which is used by both C
> > > and asm.  This also makes the code generation a bit more palatable by
> > > putting it all on a single line.
> > 
> > No objections, but I just wanted to say that when stating "this makes
> > the code generation more palatable", it would be good to actually show
> > *how* it does it (with just an example).
> > 
> > Because it's hard to read that diff and figure out what the actual
> > effect is. I can just about see it, but...
> 
> Sorry, should have added this to the changelog.
> 
> Find below a diff of the arch/x86/kernel/process.s output
> of your tree versus current tip:objtool/urgent.

It's still not exactly "pretty", but I'm looking again at how to make
all that better...  Hopefully we can get .macro working with Clang
inline asm at some point.

-- 
Josh

