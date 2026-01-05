Return-Path: <linux-tip-commits+bounces-7810-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 66284CF4902
	for <lists+linux-tip-commits@lfdr.de>; Mon, 05 Jan 2026 17:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 46FE4300D42C
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Jan 2026 16:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A22D347FFB;
	Mon,  5 Jan 2026 15:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cT0JUjmY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oo1EPeFJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658AF347BC7;
	Mon,  5 Jan 2026 15:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767628480; cv=none; b=mMhn7pFlkp1rRig+PMcSivjk7z0z6rw8ySPtivBjXg1r4TAuiyw/WrvT8JamJNmiwojcrXbuzLILmUIH13r+6Vr68oKmpT4kV776LOHhbZm++nj4FGHB2g7S7cYE+GNKCRlP44tBOTs/f+Em2J37wDXprwZ0jFbydpuKdQY9/Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767628480; c=relaxed/simple;
	bh=HonOuUq2l6gUAtlhd77EbSUzIpMDrOWjgxVmfwYE6+M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KMTA2LkuYaTWRglMWsZ2Dd92Q4y+wWupeKjbccfbD/U1EH0zUhHABYy4d0ld/ozpah+GU9HbnTOq0l6u42jeIXrKABOR2AbNOuNif1IaDPe2qjl31DaLjSuDjrcOV1mzmsT179sqUAx3iS2Qg4v+GHWjhnOGb5gUSj3kcJmzwsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cT0JUjmY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oo1EPeFJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 05 Jan 2026 15:54:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767628476;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xsTS2J2nMhpscxSAc7dXQBFOew28EgbzcN/Ce/b7PvM=;
	b=cT0JUjmYb1u3FbSuotBvqVlRvvnKLVbUsjXzvUtdt1ljzuQUNGTU0r/mbhbjhBQi7/9kPn
	ZwUWypxZggqdpqe6433czztFAm09QNlk1fqdXMbEenCNLiphenEfKw8Ifvu51o13O1KI+z
	iN+nSvvMOTR02DtgR7A8o/7BJrO7PseX7J+KKz3jvcllp0pUGDnfwGo7aDxglYWsGhy1fq
	NwaZrFeazDfFJWQgp9KnH8R6B3lDOSkvUWvtulqjY7Ix7wC1kEQO0UwG0E1FFFZHlAkdWc
	lCdhNLRjVe5uVeNuYdpcsYa/J5EkWCgkH5a14Mc7o5Lk6aGRjRa0NLnGfFfTuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767628476;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xsTS2J2nMhpscxSAc7dXQBFOew28EgbzcN/Ce/b7PvM=;
	b=oo1EPeFJtEri1N+bhi4IVgpk2rpuLQq8ldOHvN5X+QbhTpFZyCYg4wDVzU5vBZv5ePFm7a
	psXGZoVBKZAQuQAQ==
From: "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] bit_spinlock: Include missing <asm/processor.h>
Cc: Marco Elver <elver@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Bart Van Assche <bvanassche@acm.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251219154418.3592607-13-elver@google.com>
References: <20251219154418.3592607-13-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176762847561.510.14280897271476618370.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     5f7ba059710609bb997d50775ba92fbf29be51da
Gitweb:        https://git.kernel.org/tip/5f7ba059710609bb997d50775ba92fbf29b=
e51da
Author:        Marco Elver <elver@google.com>
AuthorDate:    Fri, 19 Dec 2025 16:40:01 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jan 2026 16:43:29 +01:00

bit_spinlock: Include missing <asm/processor.h>

Including <linux/bit_spinlock.h> into an empty TU will result in the
compiler complaining:

./include/linux/bit_spinlock.h:34:4: error: call to undeclared function 'cpu_=
relax'; <...>
   34 |                         cpu_relax();
      |                         ^
1 error generated.

Include <asm/processor.h> to allow including bit_spinlock.h where
<asm/processor.h> is not otherwise included.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Link: https://patch.msgid.link/20251219154418.3592607-13-elver@google.com
---
 include/linux/bit_spinlock.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/bit_spinlock.h b/include/linux/bit_spinlock.h
index c0989b5..59e345f 100644
--- a/include/linux/bit_spinlock.h
+++ b/include/linux/bit_spinlock.h
@@ -7,6 +7,8 @@
 #include <linux/atomic.h>
 #include <linux/bug.h>
=20
+#include <asm/processor.h>  /* for cpu_relax() */
+
 /*
  *  bit-based spin_lock()
  *

