Return-Path: <linux-tip-commits+bounces-4481-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EEFA6EC34
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 10:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8D5C16E150
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70912566E6;
	Tue, 25 Mar 2025 09:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="drF8yUbJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0srWyw9v"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A151253B66;
	Tue, 25 Mar 2025 09:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742893547; cv=none; b=hUCuA8zwg9trP9bgkBSlewl9d/rnUFh+08wnQ7wwLXIzARg8V/hgBjP8SM6d+4w4sz6qDuicfJxZqkj1Ls4Ue/0mrLR3x/7GklJjs5UhHHg3ibM1jhR/P0e8x/xlyWxmVacKh36Ex1t1Lnxcfy4CEhVTpj55hhQ1p1YEUF1XZNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742893547; c=relaxed/simple;
	bh=DBtXLUYvlq6Y4S6IZ1IV/Pg0q+Z4f3BqDKkgfd23n+Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LgaESOzGc/o29PqXwdnkHlZ3hMB7oaUBg89aYj056XvKZy8+7NfGHURNTuFr9Rvd/NL8OgOQVqdFlherfeEpJ82iPY1aiOrUaF4NT1dGfGTTFBiraog/2kfqKJPzqRr+NBx+NqssgHO7tFHCcLIHzWsQq+htGJbMFWb94Ws9dXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=drF8yUbJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0srWyw9v; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 09:05:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742893543;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uAD5d1Qy1xmR+1JhsmfssyHSWsYm5TuucX07Y6kzsY0=;
	b=drF8yUbJ4XPKI4JMLXn1wlCXJplZAEXG0RYeDeUWbcCE1LGOJEwmnztTIcg7F//YyrFAKk
	fTFiyeaR9j1IbgmsE72BMk24Njw5jy6OEwSxdrN1VZcp3XYpYfpKt5xUlCRv9eA6DwFCqw
	jrK5w5QbuLHfS3TOea3H2ILdNLyki06H276alNp/3IODxhtIhN0cK75rcTadO9CCSCcLaP
	4w/fpCmr+ZYKurWZHuEZWKEAlH8074GAHiUX79nFIBVWuOIkC0gNQkEttbu6g3zujYzqvO
	2NzLZ8npas0Vqi13CEr0WqM7cnpzlOcMs1nU6XNWy1uHk7cA5gp7lP+2rPt1PQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742893543;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uAD5d1Qy1xmR+1JhsmfssyHSWsYm5TuucX07Y6kzsY0=;
	b=0srWyw9vtj2iq7Ac2EJG9/XrwUYPcQKNFeHAr1L3sx7eDFkgP5/rOrRwF50RoW0Fm0h/xH
	d1sev7jWFDVtzOAw==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] tools/x86/kcpuid: Set parse_line() return type to void
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250324142042.29010-9-darwi@linutronix.de>
References: <20250324142042.29010-9-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289354293.14745.4394219433013679464.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     8984cea5c4743d7fabf5de9da142cfc5dde1a144
Gitweb:        https://git.kernel.org/tip/8984cea5c4743d7fabf5de9da142cfc5dde1a144
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Mon, 24 Mar 2025 15:20:29 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 09:53:45 +01:00

tools/x86/kcpuid: Set parse_line() return type to void

parse_line() returns an integer but its caller ignored it. Change the
function signature to return void.

While at it, adjust some of the "Skip line" comments for readability.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20250324142042.29010-9-darwi@linutronix.de
---
 tools/arch/x86/kcpuid/kcpuid.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index f268c76..4fa768b 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -277,7 +277,7 @@ struct cpuid_range *setup_cpuid_range(u32 input_eax)
  *	0,    0,  EAX,   31:0, max_basic_leafs,  Max input value for supported subleafs
  *	1,    0,  ECX,      0, sse3,  Streaming SIMD Extensions 3(SSE3)
  */
-static int parse_line(char *line)
+static void parse_line(char *line)
 {
 	char *str;
 	int i;
@@ -307,7 +307,7 @@ static int parse_line(char *line)
 
 	/* Skip comments and NULL line */
 	if (line[0] == '#' || line[0] == '\n')
-		return 0;
+		return;
 
 	strncpy(buffer, line, 511);
 	buffer[511] = 0;
@@ -330,16 +330,15 @@ static int parse_line(char *line)
 	else
 		range = leafs_basic;
 
-	index &= 0x7FFFFFFF;
 	/* Skip line parsing for non-existing indexes */
+	index &= 0x7FFFFFFF;
 	if ((int)index >= range->nr)
-		return -1;
+		return;
 
+	/* Skip line parsing if the index CPUID output is all zero */
 	func = &range->funcs[index];
-
-	/* Return if the index has no valid item on this platform */
 	if (!func->nr)
-		return 0;
+		return;
 
 	/* subleaf */
 	buf = tokens[1];
@@ -352,11 +351,11 @@ static int parse_line(char *line)
 		subleaf_start = strtoul(start, NULL, 0);
 		subleaf_end = min(subleaf_end, (u32)(func->nr - 1));
 		if (subleaf_start > subleaf_end)
-			return 0;
+			return;
 	} else {
 		subleaf_start = subleaf_end;
 		if (subleaf_start > (u32)(func->nr - 1))
-			return 0;
+			return;
 	}
 
 	/* register */
@@ -389,12 +388,11 @@ static int parse_line(char *line)
 		strcpy(bdesc->simp, strtok(tokens[4], " \t"));
 		strcpy(bdesc->detail, tokens[5]);
 	}
-	return 0;
+	return;
 
 err_exit:
 	warnx("Wrong line format:\n"
 	      "\tline[%d]: %s", flines, line);
-	return -1;
 }
 
 /* Parse csv file, and construct the array of all leafs and subleafs */

