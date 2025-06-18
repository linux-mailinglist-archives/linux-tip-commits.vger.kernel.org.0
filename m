Return-Path: <linux-tip-commits+bounces-5865-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 830CDADF2E5
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Jun 2025 18:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95EAC177B73
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Jun 2025 16:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2D72F2739;
	Wed, 18 Jun 2025 16:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s4Ey753k";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mNGwdAN1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652B52F364A;
	Wed, 18 Jun 2025 16:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750265280; cv=none; b=D6q8OY1cNTlVxdureny93LkfICNpaOOgJUFH1crNRvPcLK9A8TUZ4UliihuTGXUnvNJX3kjHIXPYhgnY9ltOgN1rR89lasmiuAcoFTyPqpbz8jN7kP6niQskkUcZvNgbVuOxJtUEWINcfBHzP01RHBUhhad7M8XkkteeyBT7OoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750265280; c=relaxed/simple;
	bh=F/RVluyB9gnjvw7OXVFevuaIVS4h51tiTmrRF0NLT9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kh9AOpggOkD9ZXobIeco1g5gkxHJ6WdpFXwDz+VDAZR4+mSRMjv/orb2ytqB3AW8wjfY7X9VVhEQkVuqyi3qcXAM4s+/0QRhuPcqsky21AKREARmB7Bh1eCO9MQzlFXGyeCqN0GcwS0B2sqd91mkSP31phXhCp+wujjNCnrm/6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s4Ey753k; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mNGwdAN1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 18 Jun 2025 18:47:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750265277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yhZT/XIdpaQC+/asQhhXC9885wUsFZcLhTwY9gLnL9Q=;
	b=s4Ey753kPGRp8tZ6qkW4IkoAWK5XmT4V9M4txoh5ZjSDeFZo+STdJ14sIKsUWvTo3vOxfm
	oj0tB4bstxuAWdrxwSiC6/c5HjfyAlQPGqiEKL3QnxiI5N9fxGks/gSUanKtSW5tRdn3Sw
	D1iAwY8Oo5qgat1We5MeUuUgiEufWXqkPoroIe9GZ7i0xzkVe2Moye4XNGpmsB1hweyGk6
	QngvKrqj3/XlhtrBX1vK/vRmss/QADpbDqwIJM957v/qJY8xHl9pPrWI4YY2SXaYbSCs6v
	/PY+ZKVBYQB9mbtiHWpTeIV4JTIl9boIOTfec3xzuOXzHSG2Qmh1/S8Z5fwzEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750265277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yhZT/XIdpaQC+/asQhhXC9885wUsFZcLhTwY9gLnL9Q=;
	b=mNGwdAN1SiRoQILU+NDXkzk2vHgUWCecG6khQaSuoyvvxCqADqHALUO9G/hQSJAwgW+bAf
	dzAprM0oizLsnYBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Calvin Owens <calvin@wbinvd.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	"Lai, Yi" <yi1.lai@linux.intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org
Subject: Re: [tip: locking/urgent] futex: Allow to resize the private local
 hash
Message-ID: <20250618164756.9CeqXYlG@linutronix.de>
References: <20250602110027.wfqbHgzb@linutronix.de>
 <174965275618.406.11364856155202390038.tip-bot2@tip-bot2>
 <aFBQ8CBKmRzEqIfS@mozart.vkv.me>
 <20250617071628.lXtqjG7C@linutronix.de>
 <aFEz_Fzr-_-nGAHV@mozart.vkv.me>
 <20250617095037.sOnrJlPX@linutronix.de>
 <aFGTmn_CFkuTbP4i@mozart.vkv.me>
 <aFIhSYmDvzRgShIy@mozart.vkv.me>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <aFIhSYmDvzRgShIy@mozart.vkv.me>

On 2025-06-17 19:15:37 [-0700], Calvin Owens wrote:
> It takes longer with LTO disabled, but I'm still seeing some crashes.
>=20
> First this WARN:
>=20
>     ------------[ cut here ]------------
>     WARNING: CPU: 2 PID: 1866190 at mm/slub.c:4753 free_large_kmalloc+0xa=
5/0xc0
>     CPU: 2 UID: 1000 PID: 1866190 Comm: python3 Not tainted 6.16.0-rc2-no=
lto-00024-g9afe652958c3 #1 PREEMPT=20
=E2=80=A6
>     RIP: 0010:free_large_kmalloc+0xa5/0xc0
=E2=80=A6
>     Call Trace:
>      <TASK>
>      futex_hash_free+0x10/0x40
This points me to kernel/futex/core.c:1535, which is futex_phash_new.
Thanks for the provided vmlinux.
This is odd. The assignment happens only under &mm->futex_hash_lock and
it a bad pointer. The kvmalloc() pointer is stored there and only
remains there if a rehash did not happen before the task ended.

>      __mmput+0xb4/0xd0
>      exec_mmap+0x1e2/0x210
>      begin_new_exec+0x491/0x6c0
>      load_elf_binary+0x25d/0x1050
=E2=80=A6
> ...and then it oopsed (same stack as my last mail) about twenty minutes
> later when I hit Ctrl+C to stop the build:
>=20
=E2=80=A6
> I enabled lockdep and I've got it running again.
>=20
> I set up a little git repo with a copy of all the traces so far, and the
> kconfigs I'm running:
>=20
>     https://github.com/jcalvinowens/lkml-debug-616
>=20
> ...and I pushed the actual vmlinux binaries here:
>=20
>     https://github.com/jcalvinowens/lkml-debug-616/releases/tag/20250617
>=20
> There were some block warnings on another machine running the same
> workload, but of course they aren't necessarily related.

I have no explanation so far.

Sebastian

