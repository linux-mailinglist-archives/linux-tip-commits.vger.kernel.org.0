Return-Path: <linux-tip-commits+bounces-5216-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1E5AA84E6
	for <lists+linux-tip-commits@lfdr.de>; Sun,  4 May 2025 10:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D9DF3B95A4
	for <lists+linux-tip-commits@lfdr.de>; Sun,  4 May 2025 08:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAA619924D;
	Sun,  4 May 2025 08:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y9uWBbHG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/a1xgWsu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94D017A306;
	Sun,  4 May 2025 08:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746348868; cv=none; b=nVdsapL2HiVsUzAp2HjdcP/n0+JbtcYosah139Py1bxhgylpiturA93mhqnW8Wq8/UQ3pFx/h3Wp1sPgc2dWl5cEyBFsdcNO9n9yn7g8E7VVhRu+DhDde8fYqubhZRGzI/tp9kuw7QyOsHKbhQ0kQsRg27MzvDIU2nGc+5MmVJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746348868; c=relaxed/simple;
	bh=7PDNRgy55qm669O77yNYSNapz7H9X+3UfqNm/NkGJzY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Puxt2i20MB/Y7XjTtynigTHck8Yg/0ETBlj+QOta61q0j9qQYFU24ikBn2BJsuqzUPnqL9u5k2GdJqBjn0HXrp5HBdfxL6Y58ObX9CUjRV9qodiE2NlSzz2Jhu5L9LuQHhrsmZkaK9Enp2p5yjGCXOPT78fp4+aGvmL9b6ge6XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y9uWBbHG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/a1xgWsu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 04 May 2025 08:54:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746348865;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MqEjuKzMKwxHejpHaF5XyqGS0DsD8y2lrdbHJuTHsAo=;
	b=y9uWBbHGnaLGami1aF6hEODzfiS8mHkyYC4f4fU5/RTyy7QdwM6XQHtW/cXsx0FPpHPdgm
	nC7TGqNxayYdfy0XW36vP9x/DubwBZ84FFA/gnEoSCLRqNaxXADQslHOHSxtblWXG/YgpG
	H2AgvGzvKfplKakWrQZIpa6QOwb0Jo66Q1s2WWHZWe2SOQ4m7hM9h84G+WKSzats2Oty58
	rynRYe9IqvfXGLT24UFVFPEafUpUV3y89EjNIgC5QJOER7jLmu2JxJwBBQKO5lKsGMmK2z
	90V+EjCuXeUTs0B6kwO6EkN1WWxBn0uOGA4zZ518ptdjTSF67/g7P7Y2Fl6UGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746348865;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MqEjuKzMKwxHejpHaF5XyqGS0DsD8y2lrdbHJuTHsAo=;
	b=/a1xgWsuprI32BZnAPuwW8jL6pKv6ChWW1DRvnHlS2mBTVzNqL0ykvJDEXBWvrlaeiCb5R
	cqLg+ZQ8t3uFjXCA==
From: "tip-bot2 for Oleg Nesterov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/fpu] x86/fpu: Remove DEFINE_EVENT(x86_fpu, x86_fpu_copy_src)
Cc: Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
 "Chang S . Bae" <chang.seok.bae@intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Andy Lutomirski <luto@amacapital.net>, Brian Gerst <brgerst@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250503143843.GA8989@redhat.com>
References: <20250503143843.GA8989@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174634886445.22196.16530195539306613274.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     8e269c030ecafbfebf4f55e24fb336fd7b489708
Gitweb:        https://git.kernel.org/tip/8e269c030ecafbfebf4f55e24fb336fd7b489708
Author:        Oleg Nesterov <oleg@redhat.com>
AuthorDate:    Sat, 03 May 2025 16:38:43 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 04 May 2025 10:29:25 +02:00

x86/fpu: Remove DEFINE_EVENT(x86_fpu, x86_fpu_copy_src)

trace_x86_fpu_copy_src() has no users after:

  22aafe3bcb67 ("x86/fpu: Remove init_task FPU state dependencies, add debugging warning for PF_KTHREAD tasks")

Remove the event.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Chang S . Bae <chang.seok.bae@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250503143843.GA8989@redhat.com
---
 arch/x86/include/asm/trace/fpu.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/x86/include/asm/trace/fpu.h b/arch/x86/include/asm/trace/fpu.h
index 4645a63..0454d5e 100644
--- a/arch/x86/include/asm/trace/fpu.h
+++ b/arch/x86/include/asm/trace/fpu.h
@@ -74,11 +74,6 @@ DEFINE_EVENT(x86_fpu, x86_fpu_dropped,
 	TP_ARGS(fpu)
 );
 
-DEFINE_EVENT(x86_fpu, x86_fpu_copy_src,
-	TP_PROTO(struct fpu *fpu),
-	TP_ARGS(fpu)
-);
-
 DEFINE_EVENT(x86_fpu, x86_fpu_copy_dst,
 	TP_PROTO(struct fpu *fpu),
 	TP_ARGS(fpu)

