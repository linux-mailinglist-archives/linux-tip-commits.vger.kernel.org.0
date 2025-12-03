Return-Path: <linux-tip-commits+bounces-7604-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C6CCA1597
	for <lists+linux-tip-commits@lfdr.de>; Wed, 03 Dec 2025 20:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCC393095AB4
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Dec 2025 18:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0C4308F07;
	Wed,  3 Dec 2025 18:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D+O1QhLd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oRvyame2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53DA3164AF;
	Wed,  3 Dec 2025 18:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764787732; cv=none; b=tYRO/J0C9r7q95mhZPi6zVe0GGLBCJ991IxG06cDXmgcz0ocPbhck4NHXkgFuSeX24l3Tg65ziP8GDE0ZO5xAvRiz5mbaTtvVeGgODnRZmGFYzr8Y1KajQbEs6TZcag5zeoz2Ce735UChRDCYqOSZmMnKcXbB/6a+8WboYJ3zTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764787732; c=relaxed/simple;
	bh=+JP6CeAx1fPbSAaRrzpesX6oORB7vQy0OU9f/TpjzQw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=atjc4B3DFwhd+SIUIqQjcpH18H8JvU08/FpHxV1fvT+O9ZKjlcfADMtLoh3xZ6W+BXcYtspLzWdrkz9wmjUUH3x8jWafdy8zHGYhCvIEk1f+DEUepBGJHzDZxyqppuDP+Kmd0yttRkdF04VVhihaCTR2eK5ALNydMk7IHj+UcSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D+O1QhLd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oRvyame2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Dec 2025 18:48:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764787727;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+3Z5o9893bvsGyi1hhRW5AJjf7XM8c/uY2m70Lw9FIw=;
	b=D+O1QhLdLd8sf7ZWxzsabyG8XLIgC1Yf7Wm9K+1Ny1A8wONdH9PKfeqzkUr/QQI8KJk3Ku
	zUCvUnvV+a5jns/tmJa+XopqCj91q7uZB0tgNYqIu320oU84PInfOjvTz/cH01ovui1sdT
	fBv+ph219Bj9WGuM/RN3QrppQU6V/B7kNNChMTyBZ8WdKceJBSakeugm9QQjcuGYmdCxLB
	Xcon9TKgMpj6tNxLUTHG6jZgxt6NLzAd69UqbGIZfa8xY37fGQ+tsTQBG2bz97iWX4jAwb
	Y4rObd52oFTV4Vx9IlEi4NBY9OB5STt09URi7Q9sp54YXvloO05CfRcj5BTTsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764787727;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+3Z5o9893bvsGyi1hhRW5AJjf7XM8c/uY2m70Lw9FIw=;
	b=oRvyame2erQtsPCqgpAS22YDRAJJpSJDtRFNNRkppy2KGWoGsKbQh0v6XxA1FXMSCJcZHj
	BHTiID8lDXjQqYBg==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: Simplify .annotate_insn code
 generation output some more
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <hpsfcihgqmhcdrg7pop7z73ptymakgjq7qlxrawrjxilosk43l@xikqif3ievj4>
References: <hpsfcihgqmhcdrg7pop7z73ptymakgjq7qlxrawrjxilosk43l@xikqif3ievj4>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176478772559.498.15765433533653931700.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     2d3451ef1ef679ae496f8e335f4b1305885e8083
Gitweb:        https://git.kernel.org/tip/2d3451ef1ef679ae496f8e335f4b1305885=
e8083
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 03 Dec 2025 10:07:38 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 03 Dec 2025 19:45:29 +01:00

objtool: Simplify .annotate_insn code generation output some more

Remove the superfluous section name quotes, and combine the longs into a
single command.

Before:

  911: .pushsection ".discard.annotate_insn", "M", @progbits, 8; .long 911b -=
 .; .long 2; .popsection

After:

  911: .pushsection .discard.annotate_insn, "M", @progbits, 8; .long 911b - .=
, 2; .popsection

No change in functionality.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://patch.msgid.link/hpsfcihgqmhcdrg7pop7z73ptymakgjq7qlxrawrjxilos=
k43l@xikqif3ievj4
---
 include/linux/annotate.h | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/linux/annotate.h b/include/linux/annotate.h
index 5efac5d..2f1599c 100644
--- a/include/linux/annotate.h
+++ b/include/linux/annotate.h
@@ -8,33 +8,32 @@
=20
 #define __ASM_ANNOTATE(section, label, type)				\
 	.pushsection section, "M", @progbits, 8;			\
-	.long label - .;						\
-	.long type;							\
+	.long label - ., type;						\
 	.popsection
=20
 #ifndef __ASSEMBLY__
=20
 #define ASM_ANNOTATE_LABEL(label, type)					\
-	__stringify(__ASM_ANNOTATE(".discard.annotate_insn", label, type))
+	__stringify(__ASM_ANNOTATE(.discard.annotate_insn, label, type))
=20
 #define ASM_ANNOTATE(type)						\
 	"911: "								\
-	__stringify(__ASM_ANNOTATE(".discard.annotate_insn", 911b, type))
+	__stringify(__ASM_ANNOTATE(.discard.annotate_insn, 911b, type))
=20
 #define ASM_ANNOTATE_DATA(type)						\
 	"912: "								\
-	__stringify(__ASM_ANNOTATE(".discard.annotate_data", 912b, type))
+	__stringify(__ASM_ANNOTATE(.discard.annotate_data, 912b, type))
=20
 #else /* __ASSEMBLY__ */
=20
 .macro ANNOTATE type
 .Lhere_\@:
-	__ASM_ANNOTATE(".discard.annotate_insn", .Lhere_\@, \type)
+	__ASM_ANNOTATE(.discard.annotate_insn, .Lhere_\@, \type)
 .endm
=20
 .macro ANNOTATE_DATA type
 .Lhere_\@:
-	__ASM_ANNOTATE(".discard.annotate_data", .Lhere_\@, \type)
+	__ASM_ANNOTATE(.discard.annotate_data, .Lhere_\@, \type)
 .endm
=20
 #endif /* __ASSEMBLY__ */

