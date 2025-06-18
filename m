Return-Path: <linux-tip-commits+bounces-5867-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 604B4ADF384
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Jun 2025 19:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E8F81782C6
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Jun 2025 17:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D064C2EA17A;
	Wed, 18 Jun 2025 17:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LEL7PzAw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mQ86ezR7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAB81A239D;
	Wed, 18 Jun 2025 17:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750266569; cv=none; b=Zk9boQwdtFNOkrtu/JhFKb2gR3uifgvXP0hVMoAehGO0GMQPwz15NlewdfGWax2Hdt7pb8KYPCyxfKjBSUTJ9BoF6qnhyUZsPx7Pfee4+HsUY9JPb+5dWcrv6c1oGFW8FCY6tceuveNdhRwO5nye8X0b939cfWTIi9kwxHgtOwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750266569; c=relaxed/simple;
	bh=iYaOEq/6HHhNI1bEO5krXmu7qfVmXwLzpqAmLN8blV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MHcSjXipIDrg6i0u9szkSQvZMoAz6qlhptuau7jClAigb6HFmhvg49RMXkFZnEzPX9aJGCVk2wBAoz+rfpMg318narVvjfF8/0y+GwfTBH06kLdkAxEajtyNDE/hjW6yIKOo3KGrbmJYO4Nm6Kd2o0jqWLoK6XnkD4wo00sc5hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LEL7PzAw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mQ86ezR7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 18 Jun 2025 19:09:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750266566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c1Kk8STBfn9fIPC+mcPJQXbQ0ozPOM/JEUS96nKhqc4=;
	b=LEL7PzAwW3C+ImfXQpLR28PSpBzHXILU2vrkGTkbv1q3Bv71kxNPD6IuaL+vTy3cv9nKZH
	vbUPTHR+vpdUYTBxUPqCUwtHtXsktaOPlVAZ0EMwLidQxk/ME1Xluf0NryDqOLLgo7u1Gh
	jeI3RG/w7i8iOlT+h/boIVZriU3BCVGVpLwT4m8b61B3+32jaFh3Yc3fVxNpYRuH9mSw+z
	sN+8XEt3vicVL29eKT1NdpTMayvnzQOYYb0+2tU1y8t30HPGYt6m8BTFIdcOGx+QRyzlIL
	64PZPPkemIRANtUAqmYNxudl8kIXjDuU7T43N3dqaR0spGA1mfp/9rmmkQuPaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750266566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c1Kk8STBfn9fIPC+mcPJQXbQ0ozPOM/JEUS96nKhqc4=;
	b=mQ86ezR7OUxwSyiJeIaPnFVHZ5FLNoJVHrNhQ537EAaNcwN5/L2v/kE/WnFogbC9KLS3Uw
	SfKjDHmVuQz3Q4Bg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Calvin Owens <calvin@wbinvd.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	"Lai, Yi" <yi1.lai@linux.intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org
Subject: Re: [tip: locking/urgent] futex: Allow to resize the private local
 hash
Message-ID: <20250618170924.Z34OXf1E@linutronix.de>
References: <20250602110027.wfqbHgzb@linutronix.de>
 <174965275618.406.11364856155202390038.tip-bot2@tip-bot2>
 <aFBQ8CBKmRzEqIfS@mozart.vkv.me>
 <20250617071628.lXtqjG7C@linutronix.de>
 <aFEz_Fzr-_-nGAHV@mozart.vkv.me>
 <20250617095037.sOnrJlPX@linutronix.de>
 <aFGTmn_CFkuTbP4i@mozart.vkv.me>
 <20250618160333.PdGB89yt@linutronix.de>
 <aFLuDoX9BGBUC3tW@mozart.vkv.me>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <aFLuDoX9BGBUC3tW@mozart.vkv.me>

On 2025-06-18 09:49:18 [-0700], Calvin Owens wrote:
> Didn't get much out of lockdep unfortunately.
>=20
> It notices the corruption in the spinlock:
>=20
>     BUG: spinlock bad magic on CPU#2, cargo/4129172
>      lock: 0xffff8881410ecdc8, .magic: dead4ead, .owner: <none>/-1, .owne=
r_cpu: -1

Yes. Which is what I assumed while I suggested this. But it complains
about bad magic. It says the magic is 0xdead4ead but this is
SPINLOCK_MAGIC. I was expecting any value but this one.

> That was followed by this WARN:
>=20
>     ------------[ cut here ]------------
>     rcuref - imbalanced put()
>     WARNING: CPU: 2 PID: 4129172 at lib/rcuref.c:266 rcuref_put_slowpath+=
0x55/0x70

This is "reasonable". If the lock is broken, the remaining memory is
probably garbage anyway. It complains there that the reference put due
to invalid counter.

=E2=80=A6
> The oops after that is from a different task this time, but it just
> looks like slab corruption:
>=20
=E2=80=A6

The previous complained an invalid free from within the exec.

> No lock/rcu splats at all.
It exploded before that could happen.

> > If it still explodes without LTO, would you mind trying gcc?
>=20
> Will do.

Thank you.

> Haven't had much luck isolating what triggers it, but if I run two copies
> of these large build jobs in a loop, it reliably triggers in 6-8 hours.
>=20
> Just to be clear, I can only trigger this on the one machine. I ran it
> through memtest86+ yesterday and it passed, FWIW, but I'm a little
> suspicious of the hardware right now too. I double checked that
> everything in the BIOS related to power/perf is at factory settings.

But then it is kind of odd that it happens only with the futex code.

Sebastian

