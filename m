Return-Path: <linux-tip-commits+bounces-1907-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B095C9458B9
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 Aug 2024 09:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64DEB2827DF
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 Aug 2024 07:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6585A33991;
	Fri,  2 Aug 2024 07:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fr5swXot";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A9NgLhjR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FDE1BE849;
	Fri,  2 Aug 2024 07:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722583728; cv=none; b=n3x4lPLxWOepgB5C+l7DFChI8OztoZ6cZKhIn+AUeFcdN6J1i8AF5fR+WnFHvO4qDZoPzIL/z2fCfBx6BvbFSpIiw8HyOkCUrjG7XuyTSXxxU1Us3Cep0BpWwpRBr44t9shHzCAPpbaYSjrxEUsz0fyDVccZ7QE5RD9BE9gUW6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722583728; c=relaxed/simple;
	bh=AX8rJPpqq4CwoTE+BFJS6lJkoA5976suMhSApXfDE3A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YTf+yKtZFcDI0/1yXBrgDzdQ7GeYOh8sFeFi1u6wIrglI2D/QqjRUCcqkKyNikMa6Hg5+WhMQ4p/8BHFFj7IifBqqnPfyX2GsWgyu2PfsSY0CFJS+85zxkT2ABTj9zMYkwCugdyvaBcTywEt7ZvnBtdr/TmpzziBKzpxFhet454=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Fr5swXot; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A9NgLhjR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 02 Aug 2024 07:28:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722583725;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OayC4uiKP95/n0b+gmKVCTLAfEUnQyT16PXrP77RFbM=;
	b=Fr5swXotvVBNostRqzlGkZU0vsBcE4gfoVpASG0VGITWeplvWSP6FwL3KIyFyS6/ycYwHA
	wy6RU4DGe3S2tMd+wF0cQYA4oJE8AEgrAnAel+UkJJei25yOw/ZypzZP7WXGxCKoKw1d6U
	FYDhqR/a8YtmnvefspgoAvNUemGknmpwkGgqY/3rMicq/MAViNWHE6jU5A0kZV/a5EadGk
	ADyZfRyFqlId303is+K65lkImCBNkHjIY6wkQwm8cZezmIVUn2AgOBVvS/I1NtrZ/kEuXe
	L6bns7gRuimjD6yMDd1WE1nZ0sNDyIfsQw3pQL0lcNMQ+pHbpUPRrKMOjqsPWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722583725;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OayC4uiKP95/n0b+gmKVCTLAfEUnQyT16PXrP77RFbM=;
	b=A9NgLhjRPWzcLG7Xci1QbZKJ3G9TwhhBM+ofFL+NbUO2o1iaPWqCQGMbf6LEey4wnHQ32I
	/6UOJb2HHHam6gAQ==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] tools/x86/kcpuid: Parse subleaf ranges if provided
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240718134755.378115-8-darwi@linutronix.de>
References: <20240718134755.378115-8-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172258372467.2215.15179877611876782990.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     58921443e9b04bbb1866070ed14ea39578302cea
Gitweb:        https://git.kernel.org/tip/58921443e9b04bbb1866070ed14ea39578302cea
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Thu, 18 Jul 2024 15:47:47 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 02 Aug 2024 09:17:19 +02:00

tools/x86/kcpuid: Parse subleaf ranges if provided

It's a common pattern in cpuid leaves to have the same bitfields format
repeated across a number of subleaves.  Typically, this is used for
enumerating hierarchial structures like cache and TLB levels, CPU
topology levels, etc.

Modify kcpuid.c to handle subleaf ranges in the CSV file subleaves
column.  For example, make it able to parse lines in the form:

 # LEAF, SUBLEAVES,  reg,    bits,    short_name             , ...
    0xb,       1:0,  eax,     4:0,    x2apic_id_shift        , ...
    0xb,       1:0,  ebx,    15:0,    domain_lcpus_count     , ...
    0xb,       1:0,  ecx,     7:0,    domain_nr              , ...

This way, full output can be printed to the user.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240718134755.378115-8-darwi@linutronix.de

---
 tools/arch/x86/kcpuid/kcpuid.c | 50 +++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index 725a7a2..1b25c0a 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -305,6 +305,8 @@ static int parse_line(char *line)
 	struct bits_desc *bdesc;
 	int reg_index;
 	char *start, *end;
+	u32 subleaf_start, subleaf_end;
+	unsigned bit_start, bit_end;
 
 	/* Skip comments and NULL line */
 	if (line[0] == '#' || line[0] == '\n')
@@ -343,13 +345,25 @@ static int parse_line(char *line)
 		return 0;
 
 	/* subleaf */
-	sub = strtoul(tokens[1], NULL, 0);
-	if ((int)sub > func->nr)
-		return -1;
+	buf = tokens[1];
+	end = strtok(buf, ":");
+	start = strtok(NULL, ":");
+	subleaf_end = strtoul(end, NULL, 0);
+
+	/* A subleaf range is given? */
+	if (start) {
+		subleaf_start = strtoul(start, NULL, 0);
+		subleaf_end = min(subleaf_end, (u32)(func->nr - 1));
+		if (subleaf_start > subleaf_end)
+			return 0;
+	} else {
+		subleaf_start = subleaf_end;
+		if (subleaf_start > (u32)(func->nr - 1))
+			return 0;
+	}
 
-	leaf = &func->leafs[sub];
+	/* register */
 	buf = tokens[2];
-
 	if (strcasestr(buf, "EAX"))
 		reg_index = R_EAX;
 	else if (strcasestr(buf, "EBX"))
@@ -361,23 +375,23 @@ static int parse_line(char *line)
 	else
 		goto err_exit;
 
-	reg = &leaf->info[reg_index];
-	bdesc = &reg->descs[reg->nr++];
-
 	/* bit flag or bits field */
 	buf = tokens[3];
-
 	end = strtok(buf, ":");
-	bdesc->end = strtoul(end, NULL, 0);
-	bdesc->start = bdesc->end;
-
-	/* start != NULL means it is bit fields */
 	start = strtok(NULL, ":");
-	if (start)
-		bdesc->start = strtoul(start, NULL, 0);
-
-	strcpy(bdesc->simp, strtok(tokens[4], " \t"));
-	strcpy(bdesc->detail, tokens[5]);
+	bit_end = strtoul(end, NULL, 0);
+	bit_start = (start) ? strtoul(start, NULL, 0) : bit_end;
+
+	for (sub = subleaf_start; sub <= subleaf_end; sub++) {
+		leaf = &func->leafs[sub];
+		reg = &leaf->info[reg_index];
+		bdesc = &reg->descs[reg->nr++];
+
+		bdesc->end = bit_end;
+		bdesc->start = bit_start;
+		strcpy(bdesc->simp, strtok(tokens[4], " \t"));
+		strcpy(bdesc->detail, tokens[5]);
+	}
 	return 0;
 
 err_exit:

