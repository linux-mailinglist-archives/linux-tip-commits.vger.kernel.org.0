Return-Path: <linux-tip-commits+bounces-7490-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C9DC7F80F
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 10:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C25614E2533
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 09:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782D52F99B0;
	Mon, 24 Nov 2025 09:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nXvOMyLh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V/UYgzPX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2322F5462;
	Mon, 24 Nov 2025 09:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975510; cv=none; b=F/3OOnm5kXyV32YOgmSdlDFA112mS4EqmQEZGR4at73E1thvS0+FE+RYu+3OO7Lt2NM6t3JjnHrsVGraIBunzJ1Br5XtZ09FnAxUhGTdO2tHyl6FhMQ++kyN0RXS4XrRSKQzZwzrff1OmiMKgACdfEDX/wpNxuSNkwN0IGegW9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975510; c=relaxed/simple;
	bh=jzj41A2XwubyX0wAh3Ktm186vBwfyLIykhZ6fmO6uKg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FHK4DLZ2ZqAXZV/njIgWr7ulTlwpp/5ZKMkXwcPf9Q/oaztnbs5gkj1JrUTxfCe4JYH+Gypsh0Kq9J6GIIv7HcT4RyNIqX+9hYEBjkN8t9vVme5/IUWGWyRMOZ4ladRqkQy+Qi2GUA7bPeF6VgytYXTQDtTmmoHcGvvCTgvt7E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nXvOMyLh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V/UYgzPX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 24 Nov 2025 09:11:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763975507;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vf4+MHLyjI1QgKDkUWdtUP7FPScOiLMZ5B6wZMr0eaA=;
	b=nXvOMyLhk1UaVLcl1Mq6q7aGeg7gOQtTVU35S57aFoybTwY3LIdliQn2tEsWRm0M5Mu4Wi
	/XZQYU/oWCRwJicxgcyHxB2NEW0zqQ0Fj3FHpFVkR0z0OvhendKAiL64tjq/QVY77hmETH
	pP00O6UY97Uwz51oJ70pl9I5w287vUdo7X3GosjlK4gvM96nhhUyPUZAB92yAP7IRWYNcv
	Iw0gH1fpZkRy/M9lyDd2SvuawAk9VEQ6IwQogRsn/MMw2WqCseNYQHccmZzPnzIptw8Gl/
	2rDPOoX+aMpWek34qGdbwcfVS4QKnaCXjfyrdmj+Zqt/YfNJuukOgQkBpJcCtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763975507;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vf4+MHLyjI1QgKDkUWdtUP7FPScOiLMZ5B6wZMr0eaA=;
	b=V/UYgzPX1zSCy5jXiaNdZITy7rqKrhgrpis3ZHVehSIDEg1TJ9TdNT/8R8kmmRiq2DCq/c
	RspTJy63zDVnLpBQ==
From: "tip-bot2 for Alexandre Chartre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Preserve alternatives order
Cc: Alexandre Chartre <alexandre.chartre@oracle.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251121095340.464045-19-alexandre.chartre@oracle.com>
References: <20251121095340.464045-19-alexandre.chartre@oracle.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176397550597.498.7510607683028171294.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     7ad7a4a72050a74f8927719272075d07d2f7777f
Gitweb:        https://git.kernel.org/tip/7ad7a4a72050a74f8927719272075d07d2f=
7777f
Author:        Alexandre Chartre <alexandre.chartre@oracle.com>
AuthorDate:    Fri, 21 Nov 2025 10:53:28 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 21 Nov 2025 15:30:12 +01:00

objtool: Preserve alternatives order

Preserve the order in which alternatives are defined. Currently
objtool stores alternatives in a list in reverse order.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://patch.msgid.link/20251121095340.464045-19-alexandre.chartre@ora=
cle.com
---
 tools/objtool/check.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 9cd9f9d..f75364f 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1921,6 +1921,7 @@ static int add_special_section_alts(struct objtool_file=
 *file)
 	struct special_alt *special_alt, *tmp;
 	enum alternative_type alt_type;
 	struct alternative *alt;
+	struct alternative *a;
=20
 	if (special_get_alts(file->elf, &special_alts))
 		return -1;
@@ -1973,9 +1974,20 @@ static int add_special_section_alts(struct objtool_fil=
e *file)
 		}
=20
 		alt->insn =3D new_insn;
-		alt->next =3D orig_insn->alts;
 		alt->type =3D alt_type;
-		orig_insn->alts =3D alt;
+		alt->next =3D NULL;
+
+		/*
+		 * Store alternatives in the same order they have been
+		 * defined.
+		 */
+		if (!orig_insn->alts) {
+			orig_insn->alts =3D alt;
+		} else {
+			for (a =3D orig_insn->alts; a->next; a =3D a->next)
+				;
+			a->next =3D alt;
+		}
=20
 		list_del(&special_alt->list);
 		free(special_alt);

