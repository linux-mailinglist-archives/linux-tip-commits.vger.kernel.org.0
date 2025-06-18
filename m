Return-Path: <linux-tip-commits+bounces-5864-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B66AADF221
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Jun 2025 18:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 105DB1893FFC
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Jun 2025 16:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451A12EBB8F;
	Wed, 18 Jun 2025 16:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nfv6D4Vh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Sjf8sSd6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7AB1E47A5;
	Wed, 18 Jun 2025 16:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750262619; cv=none; b=ZSo1nYevMa1zixH0XPAliYuSJh+JForsvzqRqOA7eZvqP6y9si+JwnFM3SkuQPPdiW5kySNZpNrzk/bHVeccSoUdrNV3eT3NgBT1bApi2SZieroF53ahYpKZLgjJ/jFZUHd0XjhF5oWEfdBfo8CCuJpD403B9VRPnwpQm3DJJhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750262619; c=relaxed/simple;
	bh=FrvU7rTVLfuUd4UWXW66itIxwUTuBoL1ExoIob/XHVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mljBBMil2a8i2l7u9BbE20HkF2wDOjYU1P2Q5r7kYPnZmz8JDVejI043lfJUfLyUel9HKY1fArrd+SDt67ro7FrLsWjwIZ7l0uSrEM6jplpZ2ZyyXW0+JHD4wb/TnVfLBZQ/bkyWGSX38pE2W9AJj1nDKoZN6uOFefnb0MyEuEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nfv6D4Vh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Sjf8sSd6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 18 Jun 2025 18:03:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750262615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wZNP7oX8mM/NEsrz1E1S/ZOqDmecinOGRR99KvBIFpk=;
	b=nfv6D4VhYhXxEtYnAnjhKDHTzERUgYVaEBvDvuHVGGmjlYeD8zDa/1z9zDJfgVcfDMYdn6
	fZfnG1OnbRJ1ozr7sJ+s35BH5yf2jFCmaQ80gT2R0ZSQ64vl+RA2vVL0pbaXqC21QCdDyi
	Is2dyiTy5fWwhB8elzCwPsuDZmEKYbzlyI9WBxSbgM64SZPoa15e1RWQQ0CqvAWxVxCic+
	jBP2qn639kCwVMmnL+o2+1HGVIzT3G0UFEyPdxRWz0ySSjcoi6uYakxl4k7S/Vg8xRyN2m
	Q7+Y4bptIXHQebGsQjF/XcxZ+8ycdJ7Lzt5+hNkWd+F14PGxmvbh81ZEhReduA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750262615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wZNP7oX8mM/NEsrz1E1S/ZOqDmecinOGRR99KvBIFpk=;
	b=Sjf8sSd6IwzMakWH9zW8wfgs+IJlrdr2y5ypBEp0ShZgM1RzLJIfyJgShT9IS33a25c32U
	IzqtV3cYgtnYEzCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Calvin Owens <calvin@wbinvd.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	"Lai, Yi" <yi1.lai@linux.intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org
Subject: Re: [tip: locking/urgent] futex: Allow to resize the private local
 hash
Message-ID: <20250618160333.PdGB89yt@linutronix.de>
References: <20250602110027.wfqbHgzb@linutronix.de>
 <174965275618.406.11364856155202390038.tip-bot2@tip-bot2>
 <aFBQ8CBKmRzEqIfS@mozart.vkv.me>
 <20250617071628.lXtqjG7C@linutronix.de>
 <aFEz_Fzr-_-nGAHV@mozart.vkv.me>
 <20250617095037.sOnrJlPX@linutronix.de>
 <aFGTmn_CFkuTbP4i@mozart.vkv.me>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <aFGTmn_CFkuTbP4i@mozart.vkv.me>

On 2025-06-17 09:11:06 [-0700], Calvin Owens wrote:
> Actually got an oops this time:
>=20
>     Oops: general protection fault, probably for non-canonical address 0x=
fdd92c90843cf111: 0000 [#1] SMP
>     CPU: 3 UID: 1000 PID: 323127 Comm: cargo Not tainted 6.16.0-rc2-lto-0=
0024-g9afe652958c3 #1 PREEMPT=20
>     Hardware name: ASRock B850 Pro-A/B850 Pro-A, BIOS 3.11 11/12/2024
>     RIP: 0010:queued_spin_lock_slowpath+0x12a/0x1d0
=E2=80=A6
>     Call Trace:
>      <TASK>
>      futex_unqueue+0x2e/0x110
>      __futex_wait+0xc5/0x130
>      futex_wait+0xee/0x180
>      do_futex+0x86/0x120
>      __se_sys_futex+0x16d/0x1e0
>      do_syscall_64+0x47/0x170
>      entry_SYSCALL_64_after_hwframe+0x4b/0x53
>     RIP: 0033:0x7f086e918779

The lock_ptr is pointing to invalid memory. It explodes within
queued_spin_lock_slowpath() which looks like decode_tail() returned a
wrong pointer/ offset.

futex_queue() adds a local futex_q to the list and its lock_ptr points
to the hb lock. Then we do schedule() and after the wakeup the lock_ptr
is NULL after a successful wake.  Otherwise it still points to the
futex_hash_bucket::lock.

Since futex_unqueue() attempts to acquire the lock, then there was no
wakeup but a timeout or a signal that ended the wait. The lock_ptr can
change during resize.
During the resize futex_rehash_private() moves the futex_q members from
the old queue to the new one. The lock is accessed within RCU and the
lock_ptr value is compared against the old value after locking. That
means it is accessed either before the rehash moved it the new hash
bucket or afterwards.
I don't see how this pointer can become invalid. RCU protects against
cleanup and the pointer compare ensures that it is the "current"
pointer.
I've been looking at clang's assembly of futex_unqueue() and it looks
correct. And futex_rehash_private() iterates over all slots.

> This is a giant Yocto build, but the comm is always cargo, so hopefully
> I can run those bits in isolation and hit it more quickly.

If it still explodes without LTO, would you mind trying gcc?

> Thanks,
> Calvin

Sebastian

