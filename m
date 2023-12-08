Return-Path: <linux-tip-commits+bounces-1-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E65E880ABB3
	for <lists+linux-tip-commits@lfdr.de>; Fri,  8 Dec 2023 19:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F61B1C208FA
	for <lists+linux-tip-commits@lfdr.de>; Fri,  8 Dec 2023 18:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD25946BB8;
	Fri,  8 Dec 2023 18:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ow8pyzuL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SQ6OuEP8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA02390;
	Fri,  8 Dec 2023 10:12:57 -0800 (PST)
Date: Fri, 08 Dec 2023 18:12:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702059176;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=VPq10NsC/rF3pTsW5VwJxHxpL7DlSSTW9H4lmsDaLFM=;
	b=Ow8pyzuL1flnJc492kWFDsRoQhzA2qs52/Kd1Pt2ViOe3IdnAC8QHHKmmZDFiUEfX/xzht
	Ly9RugGP05HXyVeAWBXdyCt9a8zzI3YYl69WlHc62MTp+MWIDN9KroFUpfuHyV3VAyGsbW
	y+w/omIeB0MVcEoSULMsyLEKzNInfLwApT0e5jbXm8bkG9gT4pF8GV4A43ewuLBJtWbXsf
	KZFfG/TAuw9SyX0tndhBm5Q7ILQBwSpo7sHnUs3EGB/K9bxMaZ8MjRz57Vxf3RgecqOAI8
	X5s2AzCXUTWTUQD6QueCS2QUx7T8KFhiDcbDT54FqGC4v8D9gcgzam/cPAmKMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702059176;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=VPq10NsC/rF3pTsW5VwJxHxpL7DlSSTW9H4lmsDaLFM=;
	b=SQ6OuEP8WsP0VeRP58uaT93aL/b8C51hnIWUvRMS8ZhwSLNorh2pYXKXIqaXouc9L4ujK6
	MqU5q9wyCqDVzoAg==
From: "tip-bot2 for Jo Van Bulck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] selftests/sgx: Remove incomplete ABI sanitization code
 in test enclave
Cc: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Jarkko Sakkinen <jarkko@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170205917549.398.11664796877429502969.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     886c5be0b12e89b2905c26c4f24d50ae91f261da
Gitweb:        https://git.kernel.org/tip/886c5be0b12e89b2905c26c4f24d50ae91f261da
Author:        Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
AuthorDate:    Thu, 05 Oct 2023 17:38:54 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 08 Dec 2023 10:05:28 -08:00

selftests/sgx: Remove incomplete ABI sanitization code in test enclave

As the selftest enclave is *not* intended for production, simplify the
code by not initializing CPU configuration registers as expected by the
ABI on enclave entry or cleansing caller-save registers on enclave exit.

Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lore.kernel.org/all/da0cfb1e-e347-f7f2-ac72-aec0ee0d867d@intel.com/
Link: https://lore.kernel.org/all/20231005153854.25566-14-jo.vanbulck%40cs.kuleuven.be
---
 tools/testing/selftests/sgx/test_encl_bootstrap.S | 16 ++------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/sgx/test_encl_bootstrap.S b/tools/testing/selftests/sgx/test_encl_bootstrap.S
index 28fe5d2..d8c4ac9 100644
--- a/tools/testing/selftests/sgx/test_encl_bootstrap.S
+++ b/tools/testing/selftests/sgx/test_encl_bootstrap.S
@@ -59,21 +59,11 @@ encl_entry_core:
 
 	push	%rcx # push the address after EENTER
 
+	# NOTE: as the selftest enclave is *not* intended for production,
+	# simplify the code by not initializing ABI registers on entry or
+	# cleansing caller-save registers on exit.
 	call	encl_body
 
-	/* Clear volatile GPRs, except RAX (EEXIT function). */
-	xor     %rcx, %rcx
-	xor     %rdx, %rdx
-	xor     %rdi, %rdi
-	xor     %rsi, %rsi
-	xor     %r8, %r8
-	xor     %r9, %r9
-	xor     %r10, %r10
-	xor     %r11, %r11
-
-	# Reset status flags.
-	add     %rdx, %rdx # OF = SF = AF = CF = 0; ZF = PF = 1
-
 	# Prepare EEXIT target by popping the address of the instruction after
 	# EENTER to RBX.
 	pop	%rbx

