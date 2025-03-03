Return-Path: <linux-tip-commits+bounces-3954-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC313A4EC3E
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 19:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EEA23A8AEB
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 18:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A3C27CCF2;
	Tue,  4 Mar 2025 18:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yTbm9ITN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MVrHjNYt"
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAE827C876
	for <linux-tip-commits@vger.kernel.org>; Tue,  4 Mar 2025 18:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741112553; cv=pass; b=DohMWz/OuvY3LC5j7G/QH9E6mK75e5m8rHETZYl6rSTnL6Bxr6WTxCDnYAJ+1UBmMAg5iJKIQGjLV2ycI6lxq5E9klDGeUvgtwZHFu5k8zzQ+Zl3B6FMaQNvTYhG+XI74mZPvt8h6dHbLl7BvSX+jFmS4GAHxYhfHDoOmqicBSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741112553; c=relaxed/simple;
	bh=yVaQgogHVfVgAJCLdmZvRLoWtKzJvI/zw0xzw+t5DZ4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OTi6mva+SbBx2EHTXkUocGrts1Gfb7R1PP9emeVP6iM1FqNYG6hxaYDcKiKPBpEiN1T8P3CL8TkKokK+5MlkV08iieFb0W9ehFvC6xwGdLYAJNESa3TpnOw+RMKdtHI4MpM2pgXZ+npXfnwT6Xu6HlwnPIayW+k7WnSz+gmvlaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yTbm9ITN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MVrHjNYt; arc=none smtp.client-ip=193.142.43.55; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; arc=pass smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id 5F1CD40D4DEE
	for <linux-tip-commits@vger.kernel.org>; Tue,  4 Mar 2025 21:22:30 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=yTbm9ITN;
	dkim=temperror header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=MVrHjNYt
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6hRY0S1VzG3ph
	for <linux-tip-commits@vger.kernel.org>; Tue,  4 Mar 2025 19:47:05 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id F100642737; Tue,  4 Mar 2025 19:46:50 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yTbm9ITN;
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MVrHjNYt
X-Envelope-From: <linux-kernel+bounces-541634-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yTbm9ITN;
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MVrHjNYt
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id F1A4542735
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:52:44 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw1.itu.edu.tr (Postfix) with SMTP id C96DD3063EFC
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:52:44 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 275A9188D1E4
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6278D20CCC2;
	Mon,  3 Mar 2025 11:51:17 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E091FF5EB;
	Mon,  3 Mar 2025 11:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741002674; cv=none; b=BUZdUFInSjdZQcgGUOQd2YRGBGKgUWOOVomMRjnFLF8rsadHvbgewjvlrSbQDicHYI6j+R+C9/karuUccgwuIJvmZ8VMKavIhUTIeGvpsM/0XlU1dEJZyx0mDAH2RQADHNLayIQuJ8Ro/11qPHjaTGcCuluDp53KaqpvmwVneUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741002674; c=relaxed/simple;
	bh=yVaQgogHVfVgAJCLdmZvRLoWtKzJvI/zw0xzw+t5DZ4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=aJpvebyNiJY8ZriLoUB7imE0lM8u9raaT9VZjfkYfHfI/HuENArZW2TpWmZc/6+PGYOP2uIZ6XRMFNzMc0r4oxEX9WNd1YuEDuEsKkOO+iOQXrqmAo0TnUon/N57rgWha24Um2Z751CzYKbEAykQE2De/ABuQYNvgfOHi1lCxyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yTbm9ITN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MVrHjNYt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Mar 2025 11:51:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741002671;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oR7C7cB+Rq7amZpDkkyqysh1+OEzoIXxnKJo7bN22Mc=;
	b=yTbm9ITNJdHz9PuYf17lWUJye0s9uQG5AdXiovnDzNxLQ9DeEwNcVbtHd36zWsUvsLEqHf
	qmPlcWTuV8XXBWiMQEXgMH2+nZswBqX9KzQt2A5sufuPt0Gz5F6g7y94lwk8juVXkcmf3E
	pORHfNKuLnY8A/JRDAR28Qa+3OeUkuYD4Ppo4VkU/zUwCBfiT+3kKlhWtaMPYGEHfg0yuf
	QvB0BnNtoMxUXf3oM6IjRxTqkL9pgICYu+Rfud2nnxj+4B4pS+dWaiXTfrIhYKiO6V6yyQ
	/T6gQU1wdNZCJMpT4/xsARLE0fjZXBXm++xvnzIagbKgOmSPHfDFgkUe5J1WPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741002671;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oR7C7cB+Rq7amZpDkkyqysh1+OEzoIXxnKJo7bN22Mc=;
	b=MVrHjNYtJsAkig0GPjSHwUE56yLxrVbeOLlJzc+TaL3REsI98/6qymoHyNI0o2qCK++VDq
	9nk3FRemGeCJ3pDQ==
From: "tip-bot2 for Mirsad Todorovac" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] selftests/x86/syscall: Fix coccinelle WARNING
 recommending the use of ARRAY_SIZE()
Cc: Mirsad Todorovac <mtodorovac69@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241101111523.1293193-2-mtodorovac69@gmail.com>
References: <20241101111523.1293193-2-mtodorovac69@gmail.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174100267008.10177.10892664815604328750.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6hRY0S1VzG3ph
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741717266.95229@NrMKu2lBgX4dm89VGIGP5Q
X-ITU-MailScanner-SpamCheck: not spam

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     40fc7561013914ec08c200bb7a0805643a23e070
Gitweb:        https://git.kernel.org/tip/40fc7561013914ec08c200bb7a0805643a23e070
Author:        Mirsad Todorovac <mtodorovac69@gmail.com>
AuthorDate:    Fri, 01 Nov 2024 12:15:23 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 03 Mar 2025 12:38:49 +01:00

selftests/x86/syscall: Fix coccinelle WARNING recommending the use of ARRAY_SIZE()

Coccinelle gives WARNING recommending the use of ARRAY_SIZE() macro definition
to improve the code readability:

  ./tools/testing/selftests/x86/syscall_numbering.c:316:35-36: WARNING: Use ARRAY_SIZE

Fixes: 15c82d98a0f78 ("selftests/x86/syscall: Update and extend syscall_numbering_64")
Signed-off-by: Mirsad Todorovac <mtodorovac69@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Link: https://lore.kernel.org/r/20241101111523.1293193-2-mtodorovac69@gmail.com
---
 tools/testing/selftests/x86/syscall_numbering.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/x86/syscall_numbering.c b/tools/testing/selftests/x86/syscall_numbering.c
index 9915917..41c42b7 100644
--- a/tools/testing/selftests/x86/syscall_numbering.c
+++ b/tools/testing/selftests/x86/syscall_numbering.c
@@ -25,6 +25,7 @@
 #include <sys/mman.h>
 
 #include <linux/ptrace.h>
+#include "../kselftest.h"
 
 /* Common system call numbers */
 #define SYS_READ	  0
@@ -313,7 +314,7 @@ static void test_syscall_numbering(void)
 	 * The MSB is supposed to be ignored, so we loop over a few
 	 * to test that out.
 	 */
-	for (size_t i = 0; i < sizeof(msbs)/sizeof(msbs[0]); i++) {
+	for (size_t i = 0; i < ARRAY_SIZE(msbs); i++) {
 		int msb = msbs[i];
 		run("Checking system calls with msb = %d (0x%x)\n",
 		    msb, msb);


