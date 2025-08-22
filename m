Return-Path: <linux-tip-commits+bounces-6309-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0486DB31711
	for <lists+linux-tip-commits@lfdr.de>; Fri, 22 Aug 2025 14:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECE8E1D009AF
	for <lists+linux-tip-commits@lfdr.de>; Fri, 22 Aug 2025 12:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDB03043A6;
	Fri, 22 Aug 2025 12:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Is6KVeWU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="no7xRGAM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E743E303CB5;
	Fri, 22 Aug 2025 12:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755864299; cv=none; b=NjDOO5yvZB3wXjxGPFcsJw6pmTFZoho5KO5R7Ex+nmHIlSY5yAIwGhO47vSv7xjHmqpZj4yxsLEqhsZ9pJPoBaU43JtGkyPBU3kBDp7PhVetiP8Dx60ERTkRQDTl0ZeuRTl3mJ0wsbvXrfhfG7drL6f9mVcVbBo7swm2Ibs2AlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755864299; c=relaxed/simple;
	bh=wXoAflquMnJ9fOAtd5oQsiYZ6SWkFwfvGG0Jut4ud1E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uAS3rm5PG4kqubhMfeWYI5S62SBGVlN8e8vw12lAm62I7s0SZyte/SATmKAt43sEhFUK8ZOUMnvm8qWCgqfQFwu1Op+oOwAkHCo0EYFiVeShh2oIYiWfaXyEjizu0ADvm3S4ffdPqMc8rKQV1/DI/gmbDqu5+0j7ybgF4urUe7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Is6KVeWU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=no7xRGAM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 22 Aug 2025 12:04:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755864295;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1LUj+JUxdqYa592kSYtdWok934ugg29P4ZPqPNucb7k=;
	b=Is6KVeWU725Jo5zZsvXY0UjaVdhdzwOQJdBZbAiYDIA2a6H2fEqBZHQ3AkqCQk6OBMy9im
	Xrx87m8ddZriTwiAfONNcxn3eJOhC26PEGAT6mGVOV8lMlYKvhsAedO+BxmCUZJEhW4NBG
	DW5d95nGbKw5+Xjz3jtRkZWoEjgiE+3h4uqjpST21PRX2c/WxTHoNtq4667Kve6BmL6ysn
	N4NiEqRSthazdIoDueoDIKs5xDr9yQwc781eOyEiGA0D+f8ZkW20Sp3y86xTZJTB0O5IDS
	RVUMwN6boyls9G+mBdViAN++EYHF9M9kxVEA03Co1urTdgeNj+eJrPT8hsxK5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755864295;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1LUj+JUxdqYa592kSYtdWok934ugg29P4ZPqPNucb7k=;
	b=no7xRGAMSNIsfXxcqxNqbvH8N7fclFtOej5TTd+82U9MlFaakwKIvussemrcOdVxdHSCBb
	8odauuZg+sziBiCw==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/idle: Use MONITORX and MWAITX mnemonics in
 <asm/mwait.h>
Cc: Uros Bizjak <ubizjak@gmail.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250616083056.157460-1-ubizjak@gmail.com>
References: <20250616083056.157460-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175586429393.1420.14916636191217721438.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     d20a5d96eddb95b4faa33247ec653a580c48fdfa
Gitweb:        https://git.kernel.org/tip/d20a5d96eddb95b4faa33247ec653a580c4=
8fdfa
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Mon, 16 Jun 2025 10:30:41 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 22 Aug 2025 13:52:21 +02:00

x86/idle: Use MONITORX and MWAITX mnemonics in <asm/mwait.h>

Current minimum required version of binutils is 2.30, which supports MONITORX
and MWAITX instruction mnemonics.

Replace the byte-wise specification of MONITORX and MWAITX with these proper
mnemonics.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250616083056.157460-1-ubizjak@gmail.com
---
 arch/x86/include/asm/mwait.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
index 6ca6516..e4815e1 100644
--- a/arch/x86/include/asm/mwait.h
+++ b/arch/x86/include/asm/mwait.h
@@ -36,9 +36,7 @@ static __always_inline void __monitor(const void *eax, u32 =
ecx, u32 edx)
=20
 static __always_inline void __monitorx(const void *eax, u32 ecx, u32 edx)
 {
-	/* "monitorx %eax, %ecx, %edx" */
-	asm volatile(".byte 0x0f, 0x01, 0xfa"
-		     :: "a" (eax), "c" (ecx), "d"(edx));
+	asm volatile("monitorx" :: "a" (eax), "c" (ecx), "d"(edx));
 }
=20
 static __always_inline void __mwait(u32 eax, u32 ecx)
@@ -80,9 +78,7 @@ static __always_inline void __mwaitx(u32 eax, u32 ebx, u32 =
ecx)
 {
 	/* No need for TSA buffer clearing on AMD */
=20
-	/* "mwaitx %eax, %ebx, %ecx" */
-	asm volatile(".byte 0x0f, 0x01, 0xfb"
-		     :: "a" (eax), "b" (ebx), "c" (ecx));
+	asm volatile("mwaitx" :: "a" (eax), "b" (ebx), "c" (ecx));
 }
=20
 /*

