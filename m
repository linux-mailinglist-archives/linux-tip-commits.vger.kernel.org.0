Return-Path: <linux-tip-commits+bounces-7520-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D90F2C8255F
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 20:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9C079349E06
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 19:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A6732D7D6;
	Mon, 24 Nov 2025 19:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NU6FF8VY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9+AV1NCd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F105319600;
	Mon, 24 Nov 2025 19:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764013765; cv=none; b=Xgl+7c9FwKVeNS9k+iLczKLMAN+KsGBneKSo5mEUsgHuYtFdQXAE20k9fjN3mAFXj8r1MKC1J9/8vJMBEdX2bMm3SWIBQqCxC8JA/A0aU1z0Sfr1Ny0aZfQIDh2fzC7fvUr+CmC1iRs9cKlL6bWZBBHzLN1OeDECbD4OYZl0MK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764013765; c=relaxed/simple;
	bh=dP+R2RhR6gZw59O9RbziYXLQMEkiuDKrveuzE2xoJMo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ajicL8/bKKd+Z41xldFuZULIU/l5gkZVedzSJn7hhLUOlpfaUoLX7vQiBEfdmgfemiSAAjVMZopsy/grEbzSysAGqT9fcuIYFJZRNKm9vm5BtoKj97NSvBB6mq8oUHs7jMWYk/uPP8HSBXN6Tu7/W9GmD9TFkeaRnUqdH0+NklY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NU6FF8VY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9+AV1NCd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 24 Nov 2025 19:49:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764013762;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HwF1dfL+xYZkmpPY24j5Pj1KXiIZWXl925n3IcO2eas=;
	b=NU6FF8VYBdCJD6XRjVHg2dnRBBujFjd25R/dT08hqFiK0rXCkn+TNtC3becvcIXICyMvtU
	6Xz2oMRDgVYgtm/n0LWr7jyT0IliDxrHqIZhU7G7YHMJMqkRWlQPeOlE9AQcmDbIw+pvuY
	SR1DBMx08U6EpJ8eIdcOnfjIZDo5iO0Ga14c8mSGAUms3n8s7StLWwhgoOrOtTovsR+n+V
	AItrblzVP4ynZedknoqzi2T6owNjtiSdGFLloJEcR1XWXaB9KzdKY4gblVp1C7Qi2OaW1/
	0aAewpuftrTj568LntaKOjPppj2O6Gy0lq2zKY608p3rfHMhUfm/bODjn3GXlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764013762;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HwF1dfL+xYZkmpPY24j5Pj1KXiIZWXl925n3IcO2eas=;
	b=9+AV1NCdFyPgFai71pFpbzrSEdAufyw66B5QdqU4z4RygPj5CDdnoW7WZ8Ea8VaURKcTSJ
	NSx33BccmYr0p/Aw==
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
Message-ID: <176401376141.498.8065075788888130568.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     07d70b271a6fc4f546b153081f3685931561be7b
Gitweb:        https://git.kernel.org/tip/07d70b271a6fc4f546b153081f368593156=
1be7b
Author:        Alexandre Chartre <alexandre.chartre@oracle.com>
AuthorDate:    Fri, 21 Nov 2025 10:53:38 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 24 Nov 2025 20:40:48 +01:00

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

