Return-Path: <linux-tip-commits+bounces-4485-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A02A6EC3E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 10:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2197B16D816
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486152571A1;
	Tue, 25 Mar 2025 09:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eTh2PLgs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VelcE5Nd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FE52561D7;
	Tue, 25 Mar 2025 09:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742893549; cv=none; b=mqsPUg1yj448tFrVnqpvrJBf9Iw3uxLPlPriC+nDiuxGUP6uNm2317wLazwCYY7OMfuz5O8xmtwWSe9hbH9bmDOgXOJkA8mDfTwfk8e12JtXb4wayw/Y/JfzALTnjamndvWBkfDMeIxRhoHPy0nsQdFuiuwWzsYwKi5VpJhlChw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742893549; c=relaxed/simple;
	bh=A0wCgn2sGT92atFUR99rlghk6Fvh/NDIRYOJOC6joOw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mlz0K73/eLwqvCeYHbrpBWZkOpcwKlhRYqXJGWWf6aKIKmUTiNzB6JcI7z71nyzyogoqJoFmDhAfqvK4WaMPGLkzqwY1DS73KRr+73UbtX4DU7kzO8ZJJTrEQtaGL6YsHV1AGD6Jvu5e5erSy6IcpAjwBFpJ42v8Cyh3ekUnZkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eTh2PLgs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VelcE5Nd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 09:05:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742893545;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Iy9hx6pRW2XHx2KiQ+eY1pm18Vft22XzhrWLYFR7tM=;
	b=eTh2PLgsqq5z3ZvoHKnQFAtsTAdgpYVZinLRFXFOYGb2iX472MbxLjDzP8FmxYDYz94l7v
	O+5qSGt1Ro36Rbu2lphYjXnzwvTvtQe2EQOOEDgIy6AYNw8HKjgrA13Mc3SET9tpqOTn2M
	oem7LVILySHnxiywONnzqX8PtIP+/n5Aq2m8g9QSzm5gu3M1wENWHt1sDWTxn0ijjb0c9I
	8y04/XZUShQoB6dQxT7g87EmcQHrjUsu7Of5KNfs6o6JSwkQBJiiwz6DJkjTmuizscM/Q+
	rRuxoZwrukCwPw8nbC7W82+KuIXFevoVow3n3b6PI4YL0WvcXmdjGwVDlqovsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742893545;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Iy9hx6pRW2XHx2KiQ+eY1pm18Vft22XzhrWLYFR7tM=;
	b=VelcE5NdB9aND9N7EzhbabM797fFpxvzv8MwegBTlc0/+SxrcYxPibEZVGI/vsYrSzAlqV
	oZUgLS4GSGMyHWAA==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cpu] tools/x86/kcpuid: Print correct CPUID output register names
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250324142042.29010-6-darwi@linutronix.de>
References: <20250324142042.29010-6-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289354488.14745.890479155784390314.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     ce61b6067d8cbfcd3607d942913b21c7ce2b384b
Gitweb:        https://git.kernel.org/tip/ce61b6067d8cbfcd3607d942913b21c7ce2b384b
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Mon, 24 Mar 2025 15:20:26 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 09:53:44 +01:00

tools/x86/kcpuid: Print correct CPUID output register names

kcpuid --all --detail claims that all bits belong to ECX, in the form
of the header CPUID_${leaf}_ECX[${subleaf}].

Print the correct register name for all CPUID output.

kcpuid --detail also dumps the raw register value if a leaf/subleaf is
covered in the CSV file, but a certain output register within it is not
covered by any CSV entry.  Since register names are now properly printed,
and since the CSV file has become exhaustive using x86-cpuid-db, remove
that value dump as it pollutes the output.

While at it, rename decode_bits() to show_reg().  This makes it match its
show_range(), show_leaf() and show_reg_header() counterparts.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20250324142042.29010-6-darwi@linutronix.de
---
 tools/arch/x86/kcpuid/kcpuid.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index 8da0e07..aa0e037 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -436,20 +436,12 @@ static void parse_text(void)
 	fclose(file);
 }
 
-
-/* Decode every eax/ebx/ecx/edx */
-static void decode_bits(u32 value, struct reg_desc *rdesc, enum cpuid_reg reg)
+static void show_reg(const struct reg_desc *rdesc, u32 value)
 {
-	struct bits_desc *bdesc;
+	const struct bits_desc *bdesc;
 	int start, end, i;
 	u32 mask;
 
-	if (!rdesc->nr) {
-		if (show_details)
-			printf("\t %s: 0x%08x\n", reg_names[reg], value);
-		return;
-	}
-
 	for (i = 0; i < rdesc->nr; i++) {
 		bdesc = &rdesc->descs[i];
 
@@ -480,18 +472,21 @@ static void decode_bits(u32 value, struct reg_desc *rdesc, enum cpuid_reg reg)
 	}
 }
 
+static void show_reg_header(bool has_entries, u32 leaf, u32 subleaf, const char *reg_name)
+{
+	if (show_details && has_entries)
+		printf("CPUID_0x%x_%s[0x%x]:\n", leaf, reg_name, subleaf);
+}
+
 static void show_leaf(struct subleaf *leaf)
 {
-	if (show_raw) {
+	if (show_raw)
 		leaf_print_raw(leaf);
-	} else {
-		if (show_details)
-			printf("CPUID_0x%x_ECX[0x%x]:\n",
-				leaf->index, leaf->sub);
-	}
 
-	for (int i = R_EAX; i < NR_REGS; i++)
-		decode_bits(leaf->output[i], &leaf->info[i], i);
+	for (int i = R_EAX; i < NR_REGS; i++) {
+		show_reg_header((leaf->info[i].nr > 0), leaf->index, leaf->sub, reg_names[i]);
+		show_reg(&leaf->info[i], leaf->output[i]);
+	}
 
 	if (!show_raw && show_details)
 		printf("\n");

