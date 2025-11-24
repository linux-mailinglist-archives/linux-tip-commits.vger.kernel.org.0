Return-Path: <linux-tip-commits+bounces-7499-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF79C7F87C
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 10:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32F5B3A7C17
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 09:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F762FD7D8;
	Mon, 24 Nov 2025 09:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b9InHbVY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tHoLnGkt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114772F547D;
	Mon, 24 Nov 2025 09:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975519; cv=none; b=UN1N5ySlDOfRtqE4wFZIqtVZWLpJInQt8pGgEkiwXv6CseTZEa+mCVI4eHrttQsl2qO5x8IsNFGKlZc8j91aqcRMdqoW1szUpviF6r34CL47VYOtJS0udT1SomcrI96wPAqfxp8RDPypZ9Nnmw5RJvbaizR82H62jR7VdyUUaxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975519; c=relaxed/simple;
	bh=QItxtAttYe3uz6aD8UIg14A7w9lWwxzxY9CjLOAkDho=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hHcsbntA6hISVJqLOcnZK+Gt+a53ZZkgicuYMPE+IKsXE/Qkf5VgD1+FSfJ8hTH+Y9ycX+yI2TG+asbyPbtymOZClEu4Q6HrpJO5ia2x+pH68VvgGlA39xvI0aOpFFta1PEcMSI6VqgInAzX1wDzMvn63749ewxmf/kZrqeLmgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b9InHbVY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tHoLnGkt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 24 Nov 2025 09:11:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763975516;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zy4IG7nwxzVgy+DUOspQu/y/xLdu+8U+lPc7KDfmows=;
	b=b9InHbVYzbfdveNp6vSWFKfauSEtFMPVz2weQ8U1sAvPBjyvOKFpr0OqblhRB1+NInDS2M
	VzoH+SdkOSqTLGXzril0YoFYfYGV/XXkIAvDJppG9yc6g/017l56hoJj7o4CjPK8ujvwQI
	wEQXx1lMViZ0nJUlgwQdTbeeROWz/p8GxfcnlSr2Zif8oVFNvEdx9mmss6NQaYIaSxaU6f
	+rlLfhJLMrhoosABNWxtNffMjJB+cbHOqIQEEPfv4pOOJ19CcUz6kHz760JoealUyW3n5D
	F68VW/QFY3zB2CfeR0wzYiAAlvBC50e8RswpdRuHtHt8oLdUCwINFNAbat5rsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763975516;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zy4IG7nwxzVgy+DUOspQu/y/xLdu+8U+lPc7KDfmows=;
	b=tHoLnGktnJYme+Up+vsIru8x4CABO0wFN7c/rqmsBuQ766OrChn2A73BI4aXceWhIgjzjq
	6CbkjGQVxtGs0DCw==
From: "tip-bot2 for Alexandre Chartre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Record symbol name max length
Cc: Alexandre Chartre <alexandre.chartre@oracle.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251121095340.464045-10-alexandre.chartre@oracle.com>
References: <20251121095340.464045-10-alexandre.chartre@oracle.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176397551514.498.7436536674784082848.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     de0248fbbf999d0fd3ca2aa5ba515ab78703d129
Gitweb:        https://git.kernel.org/tip/de0248fbbf999d0fd3ca2aa5ba515ab7870=
3d129
Author:        Alexandre Chartre <alexandre.chartre@oracle.com>
AuthorDate:    Fri, 21 Nov 2025 10:53:19 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 21 Nov 2025 15:30:09 +01:00

objtool: Record symbol name max length

Keep track of the maximum length of symbol names. This will help
formatting the code flow between different functions.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://patch.msgid.link/20251121095340.464045-10-alexandre.chartre@ora=
cle.com
---
 tools/objtool/check.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 6573056..0fbf0eb 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -37,6 +37,8 @@ static struct cfi_state init_cfi;
 static struct cfi_state func_cfi;
 static struct cfi_state force_undefined_cfi;
=20
+static size_t sym_name_max_len;
+
 struct instruction *find_insn(struct objtool_file *file,
 			      struct section *sec, unsigned long offset)
 {
@@ -2463,6 +2465,7 @@ static bool is_profiling_func(const char *name)
 static int classify_symbols(struct objtool_file *file)
 {
 	struct symbol *func;
+	size_t len;
=20
 	for_each_sym(file->elf, func) {
 		if (is_notype_sym(func) && strstarts(func->name, ".L"))
@@ -2489,6 +2492,10 @@ static int classify_symbols(struct objtool_file *file)
=20
 		if (is_profiling_func(func->name))
 			func->profiling_func =3D true;
+
+		len =3D strlen(func->name);
+		if (len > sym_name_max_len)
+			sym_name_max_len =3D len;
 	}
=20
 	return 0;

