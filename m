Return-Path: <linux-tip-commits+bounces-7521-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B51CBC82568
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 20:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9C9244E2394
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 19:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1DE32E15C;
	Mon, 24 Nov 2025 19:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s8NwGGx0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E3n/OvcO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A62932D7F3;
	Mon, 24 Nov 2025 19:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764013768; cv=none; b=XUMYsNdJaFPawAiYHsMya4H0bqfAPW/kYTkUYcPFJ1IhDsKPvQkU/cR9wzkanuYQtrhx8LHpXUU+LUOUUIBPpRz8OjjLId4YusMQoXHekJND60dfsNF0ON+FSVOdKjSnZGR/H24CBzOUvkBHxYE+9n/0+/ifnJI1tPK99Yy9n8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764013768; c=relaxed/simple;
	bh=ARVbVmWTrJ4qJq+ZmwRy5LSjpIHZfIF1jzydAvjalR0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=suDd/dAXhU3uvv9CG7cPq9uPeE2kgRNuIvdnYX6Se+1MI73l6hcfDPXjJrq1BC0+bfujiIsEbU3eAMNRF2VX3AKudcYa0jmrZS+oI0ov7BpjftqHHLGpSu7nj5jDcwFjJwX3aou6sAJ53MoC9QAC4lG3UnYuUuxPmx6aJTXKuyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s8NwGGx0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E3n/OvcO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 24 Nov 2025 19:49:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764013764;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ahd+VYu40ZeJn7PFVdEHLEAC5oq8NUNIgNCgzJrfMe0=;
	b=s8NwGGx0aGaiWB7jUcSjlFAV0FCUG0r8D418PlHE97xxmOSqHH9sCrt1AJhs1dg/R1O6Hj
	9PBfBR3Fdjcg6c/4XGXr0nF39TH38L83/uQRCp2MzZQ3XCyeHZ2gB6o4e7mrXk/aoSKzWD
	fJw4mx1FQwDfVY0WUesKTYNn02xbc1Mgt+VByxFo9s2KkXSMhkF9sQc3t6Oiskx2myBhNl
	U7lmN6ISOEFn9rguMYCYekGdRdwXUPVQNaKKJX5gmKwk7Vy3kfbrZkG0BJCfykdVlOAYlv
	lwtiOLuX+u/VJz3Ae+8Xa7jEVJiJ1Opb2JRRK7GzZ6T3/DRBm4kZIeDyntOfwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764013764;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ahd+VYu40ZeJn7PFVdEHLEAC5oq8NUNIgNCgzJrfMe0=;
	b=E3n/OvcO0bIc0eYUYVkPjzVeAu5G/5/ad2njhm5yRTrOlSQ4qoxLRJJxOGvwDZP2Rz6HR8
	+FciFSZJXrUGMPBA==
From: "tip-bot2 for Alexandre Chartre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Improve naming of group alternatives
Cc: Alexandre Chartre <alexandre.chartre@oracle.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251121095340.464045-28-alexandre.chartre@oracle.com>
References: <20251121095340.464045-28-alexandre.chartre@oracle.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176401376241.498.16449599612896812057.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     56967b9a772298ad276858ddab5a655b1d167623
Gitweb:        https://git.kernel.org/tip/56967b9a772298ad276858ddab5a655b1d1=
67623
Author:        Alexandre Chartre <alexandre.chartre@oracle.com>
AuthorDate:    Fri, 21 Nov 2025 10:53:37 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 24 Nov 2025 20:40:48 +01:00

objtool: Improve naming of group alternatives

Improve the naming of group alternatives by showing the feature name and
flags used by the alternative.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://patch.msgid.link/20251121095340.464045-28-alexandre.chartre@ora=
cle.com
---
 tools/objtool/disas.c | 58 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 6 deletions(-)

diff --git a/tools/objtool/disas.c b/tools/objtool/disas.c
index f8917c8..731c449 100644
--- a/tools/objtool/disas.c
+++ b/tools/objtool/disas.c
@@ -9,6 +9,7 @@
 #include <objtool/arch.h>
 #include <objtool/check.h>
 #include <objtool/disas.h>
+#include <objtool/special.h>
 #include <objtool/warn.h>
=20
 #include <bfd.h>
@@ -60,6 +61,21 @@ struct disas_alt {
 #define DALT_GROUP(dalt)	(DALT_INSN(dalt)->alt_group)
 #define DALT_ALTID(dalt)	((dalt)->orig_insn->offset)
=20
+#define ALT_FLAGS_SHIFT		16
+#define ALT_FLAG_NOT		(1 << 0)
+#define ALT_FLAG_DIRECT_CALL	(1 << 1)
+#define ALT_FEATURE_MASK	((1 << ALT_FLAGS_SHIFT) - 1)
+
+static int alt_feature(unsigned int ft_flags)
+{
+	return (ft_flags & ALT_FEATURE_MASK);
+}
+
+static int alt_flags(unsigned int ft_flags)
+{
+	return (ft_flags >> ALT_FLAGS_SHIFT);
+}
+
 /*
  * Wrapper around asprintf() to allocate and format a string.
  * Return the allocated string or NULL on error.
@@ -635,7 +651,12 @@ const char *disas_alt_type_name(struct instruction *insn)
  */
 char *disas_alt_name(struct alternative *alt)
 {
+	char pfx[4] =3D { 0 };
 	char *str =3D NULL;
+	const char *name;
+	int feature;
+	int flags;
+	int num;
=20
 	switch (alt->type) {
=20
@@ -649,13 +670,37 @@ char *disas_alt_name(struct alternative *alt)
=20
 	case ALT_TYPE_INSTRUCTIONS:
 		/*
-		 * This is a non-default group alternative. Create a unique
-		 * name using the offset of the first original and alternative
-		 * instructions.
+		 * This is a non-default group alternative. Create a name
+		 * based on the feature and flags associated with this
+		 * alternative. Use either the feature name (it is available)
+		 * or the feature number. And add a prefix to show the flags
+		 * used.
+		 *
+		 * Prefix flags characters:
+		 *
+		 *   '!'  alternative used when feature not enabled
+		 *   '+'  direct call alternative
+		 *   '?'  unknown flag
 		 */
-		asprintf(&str, "ALTERNATIVE %lx.%lx",
-			 alt->insn->alt_group->orig_group->first_insn->offset,
-			 alt->insn->alt_group->first_insn->offset);
+
+		feature =3D alt->insn->alt_group->feature;
+		num =3D alt_feature(feature);
+		flags =3D alt_flags(feature);
+		str =3D pfx;
+
+		if (flags & ~(ALT_FLAG_NOT | ALT_FLAG_DIRECT_CALL))
+			*str++ =3D '?';
+		if (flags & ALT_FLAG_DIRECT_CALL)
+			*str++ =3D '+';
+		if (flags & ALT_FLAG_NOT)
+			*str++ =3D '!';
+
+		name =3D arch_cpu_feature_name(num);
+		if (!name)
+			str =3D strfmt("%sFEATURE 0x%X", pfx, num);
+		else
+			str =3D strfmt("%s%s", pfx, name);
+
 		break;
 	}
=20
@@ -892,6 +937,7 @@ static void *disas_alt(struct disas_context *dctx,
 			WARN("%s has more alternatives than supported", alt_name);
 			break;
 		}
+
 		dalt =3D &dalts[i];
 		err =3D disas_alt_init(dalt, orig_insn, alt);
 		if (err) {

