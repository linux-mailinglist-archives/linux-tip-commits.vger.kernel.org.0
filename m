Return-Path: <linux-tip-commits+bounces-7481-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AD0C7F7EE
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 10:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 32188348596
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 09:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E652F5A30;
	Mon, 24 Nov 2025 09:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f3tdSnOm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4OBPwiPd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449002F5492;
	Mon, 24 Nov 2025 09:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975503; cv=none; b=lWZL+ix353t753IvvjxTiA66t63YSc+nX4w0VK8pk4EiroGg7F6mvfLQ+VpHqm3i2TliKrZnEzME9Y2kvaEPqa7fEP9/VuXf/Cswk/9LXkID8BaweWBmMx+k7AOFyktxu2KO5yWMo2DoLPEh3W0PBGWtDqLThG96px2N436LD9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975503; c=relaxed/simple;
	bh=aeGf3u2alRqRQNYe+Guk1FwpgUVe9L+FDuUYKdUYD+w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TgkERw9bNLmckdqJQNcmbmHNNh8idf36IDRHnauW1t6dr8LCEUR7rPxZnEvwZp6CPHIwCcjWJB8J5N1IEktlgcCgfXnF8g4OIijUpYM9HFyUzciKG8EpkOTcgXIU73sWusj14q6F2bF3dJor/r2CvnyN6HZiR6HwXN6zy+XaR4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f3tdSnOm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4OBPwiPd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 24 Nov 2025 09:11:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763975497;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q9RJWG37m1nSirY4ByRlMLi4/3YW1yYV2f6IYrQpUVs=;
	b=f3tdSnOmj3PN1YecpttIVjRTWhjxOJw6QGkMlReO46I8qVyuSWp5X3EEv6giDuWTWYX5Qr
	Gu1H2PYLAFwsTX7CtVPjmxhGvnNF2ZUp1pAmoGXDVEojUYh5jMbs1vLFWoD/9C5fMqpuXH
	tX/gQCXWQTzX7ta/ixg2sacyBrhgYFTKOOBz+34y9mj/Jko3o4jkvINMBM2Qudw0V0mI4g
	A09wJYolFsVkV1PhZc2pYofegs2p/zExoNh7LHhRmqZlTJxNg16kndIFlyCUuhA9AHW9sP
	n7u2U6QVao4Ixqv7aOSZhUsS18TqSVRGu72Lt6U9Wr7kz/elLhzMNlYZVgcZxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763975497;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q9RJWG37m1nSirY4ByRlMLi4/3YW1yYV2f6IYrQpUVs=;
	b=4OBPwiPdt7/I33bUcKBu8sLXZC/AXx9+w62ktlmWm305wVZgVbchk4i972pmYlZqwlpeXh
	jcKuHzVlgvnNybDw==
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
Message-ID: <176397549659.498.5912577737450910435.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     c8455e83c219740b4a0ac73b28db18023cd4c6a0
Gitweb:        https://git.kernel.org/tip/c8455e83c219740b4a0ac73b28db18023cd=
4c6a0
Author:        Alexandre Chartre <alexandre.chartre@oracle.com>
AuthorDate:    Fri, 21 Nov 2025 10:53:37 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 21 Nov 2025 15:30:15 +01:00

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

