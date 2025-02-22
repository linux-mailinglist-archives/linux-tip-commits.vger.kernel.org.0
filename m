Return-Path: <linux-tip-commits+bounces-3597-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30ADBA40820
	for <lists+linux-tip-commits@lfdr.de>; Sat, 22 Feb 2025 12:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 796AA189C59B
	for <lists+linux-tip-commits@lfdr.de>; Sat, 22 Feb 2025 11:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B821320A5F2;
	Sat, 22 Feb 2025 11:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fyiFI5Mk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UmxNczp7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE67207E1D;
	Sat, 22 Feb 2025 11:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740225384; cv=none; b=KpSNrwe1YjEykHnStgw9iwXftkhrLNGYdPw2WIgKrv8MFlzN7BaNBNbcMvSh8UazXufsdUPqudnw+BNdvQvKqPuE8vP3OtiCZ78J1bys5MHmj7pLcUWbt2ctgs0xPX9o33x/DrrwUbeyzzJ2IyYrMwxKu8uJEj5TZ6YWmr3BG/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740225384; c=relaxed/simple;
	bh=KYSfkje7X556VxeNSSAvYMvUQhEwUtbVDzQDenE6Y6Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=c/3w7eWoEC/6ZkHs11Yx406rTGlRXuc4EShZl1Jm91/2SQvG6Z//cptpIQe7dI+c5nzoAH8HlqB6q9gai85Bicb+39jPskB7QvfFkMoIv4/k/gyiUylYlt8k4tD6iA0PRX0btdokLWeob2iJrWQ6uf7jkWFfbvv0U+/VyUhHBOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fyiFI5Mk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UmxNczp7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 22 Feb 2025 11:56:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740225381;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hr0Q9dJ0X8BWEnUAphfvBKZPgH4Rn+4SU2TZki1qkhc=;
	b=fyiFI5MkSMDQH561RL+d5Ai4Pw9VXe0GzUjN26fSSy4xDR42D6JFn6miopLwCam0exwW32
	/Lpx11neD/2VnjtvRI0qZ46MZ5GgQRhTg85+kMwlDxzCuebYgfOq19xXqnnjh+ixlJDTns
	l2e6wL4asn3wkO9p3B83UQdW3Bjh1vOqwOzVs3ES2dhcGu991Iole8n7J7kUN1xq17XTU4
	g53Q1Yg6f3oHN82AL0mphLdPvXMKA5uSXW8smyYqB0cJqyuOOl7yZDhaUxc93j/rTSTziw
	Q90swzpYEcRc3PCutTu6/Y7Nd8zanRYzh/OvDxD4AXxwVgNORyhEaH2KnJNieA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740225381;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hr0Q9dJ0X8BWEnUAphfvBKZPgH4Rn+4SU2TZki1qkhc=;
	b=UmxNczp7672c0qDayqFZn11mG8JwhhVWq8pm5QuQfc7sDdvMTCcemJTCn/IHyvd0+RMyPF
	YLT/85Hjt6oNU9Bw==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/boot] x86/boot: Change some static bootflag functions to bool
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250129154920.6773-1-ubizjak@gmail.com>
References: <20250129154920.6773-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174022538091.10177.7409220416524684215.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     5bebe2e4fe27bf68b4993d62be2f8bae9e6229d6
Gitweb:        https://git.kernel.org/tip/5bebe2e4fe27bf68b4993d62be2f8bae9e6229d6
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Wed, 29 Jan 2025 16:47:50 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 22 Feb 2025 12:30:59 +01:00

x86/boot: Change some static bootflag functions to bool

The return values of some functions are of boolean type. Change the
type of these function to bool and adjust their return values.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250129154920.6773-1-ubizjak@gmail.com
---
 arch/x86/kernel/bootflag.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/bootflag.c b/arch/x86/kernel/bootflag.c
index 3fed7ae..4d89a2d 100644
--- a/arch/x86/kernel/bootflag.c
+++ b/arch/x86/kernel/bootflag.c
@@ -20,7 +20,7 @@
 
 int sbf_port __initdata = -1;	/* set via acpi_boot_init() */
 
-static int __init parity(u8 v)
+static bool __init parity(u8 v)
 {
 	int x = 0;
 	int i;
@@ -30,7 +30,7 @@ static int __init parity(u8 v)
 		v >>= 1;
 	}
 
-	return x;
+	return !!x;
 }
 
 static void __init sbf_write(u8 v)
@@ -66,14 +66,14 @@ static u8 __init sbf_read(void)
 	return v;
 }
 
-static int __init sbf_value_valid(u8 v)
+static bool __init sbf_value_valid(u8 v)
 {
 	if (v & SBF_RESERVED)		/* Reserved bits */
-		return 0;
+		return false;
 	if (!parity(v))
-		return 0;
+		return false;
 
-	return 1;
+	return true;
 }
 
 static int __init sbf_init(void)

