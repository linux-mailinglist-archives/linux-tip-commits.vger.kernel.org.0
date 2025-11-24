Return-Path: <linux-tip-commits+bounces-7510-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DEBCC7FF73
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 11:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2A1A1341E57
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 10:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92AFB1EA65;
	Mon, 24 Nov 2025 10:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1dmyal45";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nw6BgnV4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49442FB62A;
	Mon, 24 Nov 2025 10:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763981047; cv=none; b=LfeGRp0wY3RHpeFrMuwSP+YfrzYeUc1bkoA248ZKDvigQk3pQS5eL9ll1K5ED2ScgMiUzBQgIQ7G8jHCv3x1Q288MSvh+hjNC19s5xBZGHj/lDLdGJMc7X5xbMjE1bVNO5RtDMHDNScz/oSRMc4W+xJmFGOPq44jltG+0qR2ag8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763981047; c=relaxed/simple;
	bh=EKG7Z4B4pZUnoiNH9YKiBso92mmrY+LTM5a6XCrOS7k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=afZT5kwmWnCidFSgPpAIogV5NSWpGHFnVhx3dZWK5TIqcETrYWLURbfc4JpHimESxW7BYY0nrZkU9gm6H+GyfskwTk755NTCSpr9yM2o0cEUdrFSgDWFIMTYMYmD+hPa0o5NYRMgzZ+bgncLmCMtDj4xXLX8AOPOKRHFO0f6rdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1dmyal45; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nw6BgnV4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 24 Nov 2025 10:43:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763981040;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A1OtqBxne+MEhwTDivX6TLehPOlUiCIbb++lO4oR+Sk=;
	b=1dmyal45AuXVLI4aRBOnOqqPThjArtTbEOgvhiX61dCkol+EFW+KrRvswZ7pznWUEFNEB3
	jMfa0YMy2tykG5gOAxyMmtO554DG/QfBlkJ2+Okz1V+PXe4zuN2+zLTNcD7VtkiEhW8Adv
	Jdz3zapUKTy2esHBPDKcyQqoD2ava+MrR86L3ugTH+fsQKIOP4RMhCj18a6w9L38Mrg3IS
	8sJMJT397k08QbmqYNbMkEQrjnDF4O109nxCsIG4ZW2z4ZChJdzoiOzwWv/aZti28eSDzH
	8dzjPuwNLECEkBHcYQ4m7TUZgcoANljHwmV7SmIVvTiEpcARgbH3TmgbCSvdWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763981040;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A1OtqBxne+MEhwTDivX6TLehPOlUiCIbb++lO4oR+Sk=;
	b=nw6BgnV4Pf68IL2ULZZdDuZN8yvWgtWuPS+CK8jHya6GW+XD1V+FI8iQBnsbb//BXR/Wne
	6g0+fMflsj8r7LCA==
From: "tip-bot2 for Alexandre Chartre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Compact output for alternatives with one
 instruction
Cc: Alexandre Chartre <alexandre.chartre@oracle.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251121095340.464045-29-alexandre.chartre@oracle.com>
References: <20251121095340.464045-29-alexandre.chartre@oracle.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176398103956.498.2232385834971967837.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     59736d6418ace7537e10aaf9b28b671a100abe45
Gitweb:        https://git.kernel.org/tip/59736d6418ace7537e10aaf9b28b671a100=
abe45
Author:        Alexandre Chartre <alexandre.chartre@oracle.com>
AuthorDate:    Fri, 21 Nov 2025 10:53:38 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 24 Nov 2025 11:35:16 +01:00

objtool: Compact output for alternatives with one instruction

When disassembling, if an instruction has alternatives which are all
made of a single instruction then print each alternative on a single
line (instruction + description) so that the output is more compact.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://patch.msgid.link/20251121095340.464045-29-alexandre.chartre@ora=
cle.com
---
 tools/objtool/disas.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/objtool/disas.c b/tools/objtool/disas.c
index 731c449..a4f905e 100644
--- a/tools/objtool/disas.c
+++ b/tools/objtool/disas.c
@@ -863,6 +863,7 @@ static void disas_alt_print_compact(char *alt_name, struc=
t disas_alt *dalts,
 				    int alt_count, int insn_count)
 {
 	struct instruction *orig_insn;
+	int width;
 	int i, j;
 	int len;
=20
@@ -871,6 +872,27 @@ static void disas_alt_print_compact(char *alt_name, stru=
ct disas_alt *dalts,
 	len =3D disas_print(stdout, orig_insn->sec, orig_insn->offset, 0, NULL);
 	printf("%s\n", alt_name);
=20
+	/*
+	 * If all alternatives have a single instruction then print each
+	 * alternative on a single line. Otherwise, print alternatives
+	 * one above the other with a clear separation.
+	 */
+
+	if (insn_count =3D=3D 1) {
+		width =3D 0;
+		for (i =3D 0; i < alt_count; i++) {
+			if (dalts[i].width > width)
+				width =3D dalts[i].width;
+		}
+
+		for (i =3D 0; i < alt_count; i++) {
+			printf("%*s=3D %-*s    (if %s)\n", len, "", width,
+			       dalts[i].insn[0].str, dalts[i].name);
+		}
+
+		return;
+	}
+
 	for (i =3D 0; i < alt_count; i++) {
 		printf("%*s=3D %s\n", len, "", dalts[i].name);
 		for (j =3D 0; j < insn_count; j++) {

