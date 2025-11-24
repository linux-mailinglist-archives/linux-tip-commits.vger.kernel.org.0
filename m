Return-Path: <linux-tip-commits+bounces-7480-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5D7C7F7EB
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 10:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2167434787F
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 09:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12BC2F5A13;
	Mon, 24 Nov 2025 09:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JNzx79LZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/kwfDpkF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449782F5499;
	Mon, 24 Nov 2025 09:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975501; cv=none; b=sIMVd4yfN2ZQHguwqQiuaPw0vR/LEsRZTfCpk5wZlF1MLJtMjlMnjjrorSgJ1T+xh9DUBwN/6/nfm3KI3Pro3DWlUw0pmtWJ45he5/DNuOz/NsTMd4nReesrgL0AtDj8iKPFqMNtVACacYsWbV53Yp0P3giMAdUuWlzoWduPgRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975501; c=relaxed/simple;
	bh=R8VbqDUwMqSaY8nPEfURgXhGd3a1Rz2kEnCvkQ85lgE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=A30q7iExaWn+pW9u+o64elHqhMd8zSAT76aIihiib9uW5D7uWn9qbr/+VT/60N1IEyMYEjUdwq1HnsAkjQRRhKQAUlsQSu2qDMulDM/XyAGtNcz9yZ72/wDbDfjaiAN6pYLJg48SNQ9H/vNpKziSd3ZMFnhKpet9plD4PnndCdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JNzx79LZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/kwfDpkF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 24 Nov 2025 09:11:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763975496;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r3YD6nxPxzSxyX8oZYpTWhWAD+0FIvIRIc3p0ZE6K2s=;
	b=JNzx79LZDET7+Ynn7zZukT5lOOX2keJ1j4HvgC/hM2omifXkuhERq/7tM8E8IJjMEsf2FI
	8EE0d2ryoxjGoFf4z6n5RLoNJ1T5Uf5MkX7OHym8YuXQiT16RoYOfqSaoJ0gX3R2F/LQow
	GnOeT+ieot2nyONPx0Cy4uX/hTZaMQ056izYSY0RUoKVYByeCLYMUgu9ZUK8EY699Kv1zq
	DbS9fV5MZJp0NIlnd+8ZD/Ox7deHD5BWMR3ewWugLk02WpsgeuYd99RDweTslwycV9IT0w
	ghI1uy/c4AdjO0o5QHQ30J87f44oGO0yAI6Hg4sRPNNqTaWBXlMpW2RPCx2egg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763975496;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r3YD6nxPxzSxyX8oZYpTWhWAD+0FIvIRIc3p0ZE6K2s=;
	b=/kwfDpkF4ivx/brIHNrqqY2sT47oJB2Bs6sKzUDR7/gqjxAMj2dauQTTC3rn+vh9X/HUsR
	LLUiQugEl58wF/Cg==
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
Message-ID: <176397549550.498.13316141540053358154.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     5b4d0034e8a56695d1c25b18d2ef29e199d8e5fa
Gitweb:        https://git.kernel.org/tip/5b4d0034e8a56695d1c25b18d2ef29e199d=
8e5fa
Author:        Alexandre Chartre <alexandre.chartre@oracle.com>
AuthorDate:    Fri, 21 Nov 2025 10:53:38 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 21 Nov 2025 15:30:15 +01:00

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

