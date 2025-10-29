Return-Path: <linux-tip-commits+bounces-7038-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2369CC19679
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 10:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0D7DB4EC5B6
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 09:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0C8328621;
	Wed, 29 Oct 2025 09:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NxN8bf9p";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wlcaUBFK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF8B2F6596;
	Wed, 29 Oct 2025 09:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761730575; cv=none; b=NMPmKqUjqFiv3tM79eMtQUFkD+nOwZi9uU4hUKeMZTcevsLl4j6JFvRSA+oOxWMQIgBBRCtulsT3aTrkQMlhDcNK0+BMwvjBh7gPiHR6ohUeH9nj9aop0alYSMihyuKLMOre98RQvanpkimECWBLNAuEhJUabsb5v57mFrPuGF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761730575; c=relaxed/simple;
	bh=2gDyL2FYA+aJzRI1gyPHGPw1tFwBgeaEX4XWvEQIxM8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KUTuxHNSW5xdDLqIbb9/hNATN+XEPolaIVxgd9fjkhWr3TZuceKpHtI/lHrvI7UmFGNdugHwJjF571XN/hdpFagfj0UBQXHBKMcnk9P8fCX+BdXm37GZxVTjQeA/Zrg5B3cLwdsheXYWZXmMIcUvNeplR3DKiPStx8M48ZcioIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NxN8bf9p; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wlcaUBFK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 Oct 2025 09:36:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761730572;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9RmQKQtKG9U/T7OwV1ElLt6A3/UpsMHGtHVvrt5XdwA=;
	b=NxN8bf9paClDJysJU9D9HHH8qZviiJ0fNUeBMXJEvynXe+C1IhpXfPjpHyBR4+WuK6c3GT
	29NhbFm6ssJ9VgLFh3sUKVxOK2WBZSDT306gHz1O0r1J2iDpkQj75v4oQaoBRMPBnOs/SK
	81+qMVdHyebY9VFyumVwKueupQ76scas9kF215d9tABbmL/p7aA19BoNmDs7rGjlonSQi9
	T4DVoL1QfxogcexW3m16avCZsxXQgLnFIHqHvdT5hZKwFzEDLxek1LiZjOtaJ0E32LuMCc
	pcF/f7egeDWPBluwvBptnPwaEdTpj7DD2HrGN5oLFqVzDr7D/ZFh9JwnabPlxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761730572;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9RmQKQtKG9U/T7OwV1ElLt6A3/UpsMHGtHVvrt5XdwA=;
	b=wlcaUBFKoK3VXxUewn5ZdR7pckI22Dm9IxFG2ud88sPRInSTYwUiJF6yrUXKiYYBUqXLuK
	ibuSPvKjA7MDrhAg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] unwind: Implement compat fp unwind
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250924080119.613695709@infradead.org>
References: <20250924080119.613695709@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176173057065.2601451.8068524787042290202.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     c79dd946e370af3537edb854f210cba3a94b4516
Gitweb:        https://git.kernel.org/tip/c79dd946e370af3537edb854f210cba3a94=
b4516
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 23 Sep 2025 13:27:34 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Oct 2025 10:29:57 +01:00

unwind: Implement compat fp unwind

It is important to be able to unwind compat tasks too.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20250924080119.613695709@infradead.org
---
 include/linux/unwind_user_types.h |  1 +-
 kernel/unwind/user.c              | 40 +++++++++++++++++++++---------
 2 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/include/linux/unwind_user_types.h b/include/linux/unwind_user_ty=
pes.h
index a449f15..938f7e6 100644
--- a/include/linux/unwind_user_types.h
+++ b/include/linux/unwind_user_types.h
@@ -36,6 +36,7 @@ struct unwind_user_state {
 	unsigned long				ip;
 	unsigned long				sp;
 	unsigned long				fp;
+	unsigned int				ws;
 	enum unwind_user_type			current_type;
 	unsigned int				available_types;
 	bool					done;
diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
index 9dcde79..6428715 100644
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -8,19 +8,32 @@
 #include <linux/unwind_user.h>
 #include <linux/uaccess.h>
=20
-static const struct unwind_user_frame fp_frame =3D {
-	ARCH_INIT_USER_FP_FRAME
-};
-
 #define for_each_user_frame(state) \
 	for (unwind_user_start(state); !(state)->done; unwind_user_next(state))
=20
+static inline int
+get_user_word(unsigned long *word, unsigned long base, int off, unsigned int=
 ws)
+{
+	unsigned long __user *addr =3D (void __user *)base + off;
+#ifdef CONFIG_COMPAT
+	if (ws =3D=3D sizeof(int)) {
+		unsigned int data;
+		int ret =3D get_user(data, (unsigned int __user *)addr);
+		*word =3D data;
+		return ret;
+	}
+#endif
+	return get_user(*word, addr);
+}
+
 static int unwind_user_next_fp(struct unwind_user_state *state)
 {
-	const struct unwind_user_frame *frame =3D &fp_frame;
+	const struct unwind_user_frame frame =3D {
+		ARCH_INIT_USER_FP_FRAME(state->ws)
+	};
 	unsigned long cfa, fp, ra;
=20
-	if (frame->use_fp) {
+	if (frame.use_fp) {
 		if (state->fp < state->sp)
 			return -EINVAL;
 		cfa =3D state->fp;
@@ -29,26 +42,26 @@ static int unwind_user_next_fp(struct unwind_user_state *=
state)
 	}
=20
 	/* Get the Canonical Frame Address (CFA) */
-	cfa +=3D frame->cfa_off;
+	cfa +=3D frame.cfa_off;
=20
 	/* stack going in wrong direction? */
 	if (cfa <=3D state->sp)
 		return -EINVAL;
=20
 	/* Make sure that the address is word aligned */
-	if (cfa & (sizeof(long) - 1))
+	if (cfa & (state->ws - 1))
 		return -EINVAL;
=20
 	/* Find the Return Address (RA) */
-	if (get_user(ra, (unsigned long *)(cfa + frame->ra_off)))
+	if (get_user_word(&ra, cfa, frame.ra_off, state->ws))
 		return -EINVAL;
=20
-	if (frame->fp_off && get_user(fp, (unsigned long __user *)(cfa + frame->fp_=
off)))
+	if (frame.fp_off && get_user_word(&fp, cfa, frame.fp_off, state->ws))
 		return -EINVAL;
=20
 	state->ip =3D ra;
 	state->sp =3D cfa;
-	if (frame->fp_off)
+	if (frame.fp_off)
 		state->fp =3D fp;
 	return 0;
 }
@@ -100,6 +113,11 @@ static int unwind_user_start(struct unwind_user_state *s=
tate)
 	state->ip =3D instruction_pointer(regs);
 	state->sp =3D user_stack_pointer(regs);
 	state->fp =3D frame_pointer(regs);
+	state->ws =3D unwind_user_word_size(regs);
+	if (!state->ws) {
+		state->done =3D true;
+		return -EINVAL;
+	}
=20
 	return 0;
 }

