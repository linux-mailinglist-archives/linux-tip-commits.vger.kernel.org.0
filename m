Return-Path: <linux-tip-commits+bounces-7352-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DE9C5E1E9
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Nov 2025 17:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B0CC94F849E
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Nov 2025 15:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87F8330B28;
	Fri, 14 Nov 2025 15:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kt3m/P99";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ryKYMvaV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73EC330319;
	Fri, 14 Nov 2025 15:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763134395; cv=none; b=OBi5HUkS80YfScLcA+or61Q3USmmWkBQZtb7SlS5b+j71b0gh6G+SkdqxsrEQ6hBNSiw1LsmTDMQOdV/qw65XEgJrqGyX7ukR/zrdb3D3r7R7xladU7KVbgkhQuI0viQcAz5QMIvVvgKFIYx7avyM8wcQq/jr+u/G/ncEkbJ960=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763134395; c=relaxed/simple;
	bh=oY5smn4SWEgnjJzr/lR2og8xIGpNCGGVEsDmjtQ0qZc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=azYhvvzb0Lv7eZLpYuJXy6ln3WHQsWLNRhxeM0WU1XczY6IJIAyOzCW0QM7H/ytgUA4N7Dgr1lzROwlZe2cjMLEsH11GUROoiaLKhDW5grv9Sy8mliEDtS5s8nwgf95lQt7hQPdPsg9lov5vxarUSxA2IyqHwEYsMfEzKsTXhro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kt3m/P99; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ryKYMvaV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Nov 2025 15:33:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763134392;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mXvbnX9ZSE01FLzqK+mbu1qBPEPkf1vXsHvmj4MBQ08=;
	b=kt3m/P99stMgiD803IYKIoLZC2gEIJfW/HBtFFOCukX5cXOQvMUF7p8Z/LCXTUV2okTtt7
	FQKG6pZbx0yWSmR3sHHBNF5s4q7aSd6S4BQkYA0SRsksuIOfDyMgbH7s7IyhQrnt5Sx0ra
	LD/kYoynCm0uk05MOLDCI6MJCQiMFiXqETtlJKhpMxDrDUWqaPmhUptJkAs2BCdGXGZ5Vh
	+8FmW6w8Lw9Q9MonwfXyYO/bndnVBPNA5BCEtidNHW331Qr9FoyOpzqFCfTkzKYF+qSsWC
	OABOdpmLCEDVAAfzYqO8whWwEz5i76GeXIFW9qJ4M2QXBbUbqOf4/3FDa4jALQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763134392;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mXvbnX9ZSE01FLzqK+mbu1qBPEPkf1vXsHvmj4MBQ08=;
	b=ryKYMvaVGlxcAScVnX3UGoV0GJKBvobDFTZAk3l+5aQGStCHTNDsWGc11pcf7uVH0RRv2r
	DuAJ9wJsZOofcSBQ==
From: "tip-bot2 for Boqun Feng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/core] rust: sync: atomic: Implement Debug for Atomic<Debug>
Cc: David Gow <davidgow@google.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 Boqun Feng <boqun.feng@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251022035324.70785-3-boqun.feng@gmail.com>
References: <20251022035324.70785-3-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176313439079.498.4521363360222860326.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     013f912eb5fa7c06b3648ca630acfc4ff26456fa
Gitweb:        https://git.kernel.org/tip/013f912eb5fa7c06b3648ca630acfc4ff26=
456fa
Author:        Boqun Feng <boqun.feng@gmail.com>
AuthorDate:    Tue, 21 Oct 2025 23:53:23 -04:00
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Wed, 12 Nov 2025 08:56:41 -08:00

rust: sync: atomic: Implement Debug for Atomic<Debug>

If `Atomic<T>` is `Debug` then it's a `debugfs::Writer`, therefore make
it so since 1) debugfs needs to support `Atomic<T>` and 2) it's rather
trivial to implement `Debug` for `Atomic<Debug>`.

Tested-by: David Gow <davidgow@google.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://patch.msgid.link/20251022035324.70785-3-boqun.feng@gmail.com
---
 rust/kernel/sync/atomic.rs |  9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
index 0bc6e7b..3afc376 100644
--- a/rust/kernel/sync/atomic.rs
+++ b/rust/kernel/sync/atomic.rs
@@ -307,6 +307,15 @@ where
     }
 }
=20
+impl<T: AtomicType + core::fmt::Debug> core::fmt::Debug for Atomic<T>
+where
+    T::Repr: AtomicBasicOps,
+{
+    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
+        core::fmt::Debug::fmt(&self.load(Relaxed), f)
+    }
+}
+
 impl<T: AtomicType> Atomic<T>
 where
     T::Repr: AtomicExchangeOps,

