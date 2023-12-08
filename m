Return-Path: <linux-tip-commits+bounces-1-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F38C80ABBB
	for <lists+linux-tip-commits@lfdr.de>; Fri,  8 Dec 2023 19:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE122281806
	for <lists+linux-tip-commits@lfdr.de>; Fri,  8 Dec 2023 18:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3C546B9F;
	Fri,  8 Dec 2023 18:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fZLsZDj2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ykwsQkdM"
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CC211F;
	Fri,  8 Dec 2023 10:13:02 -0800 (PST)
Date: Fri, 08 Dec 2023 18:13:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702059181;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=yvm4+gDjc9yZRURvOF5hsHgmgIuQOiG3VThauBnHAuM=;
	b=fZLsZDj2W6KDZXbVMq6WgFFW3z1ROEn+G8dQ0q1ZbNpvWaluEv2XEYb0ezcy1FDA2NQPrg
	zKHaLjtpsYsbnjBE9C/iv5nJ0/wXI4EqYFnDMDiIF/YnhJXmpuumzRZL9WP3iP5ojse36s
	Gw4FHrq3Z776a0HC0PLlSTTwpgJ+P7PfB88FakU2BhpQaSRHV4N+gEkbUg5tBjPmLIsA7k
	9uDxsPhFgv0wd30UBh1osbtPgLCgKmPhQ5JTKK1X5HvF5bNCfXaEHCafwWMdF9t0SGaoNw
	iJVoJeOkETctHb4W0AYdQ2JwryBTqeWIQG0CZOqKcMxBLpTQBg6qmLNHgnqCOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702059181;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=yvm4+gDjc9yZRURvOF5hsHgmgIuQOiG3VThauBnHAuM=;
	b=ykwsQkdMATCkFAftugd7iv8fmMHJDGUNWIsie3le/1SNNYWtw/+u7gb/2F9cm2+YKciZMp
	7lfUoQUkhzZjY9Dw==
From: "tip-bot2 for Jo Van Bulck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] selftests/sgx: Remove redundant enclave base address
 save/restore
Cc: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Jarkko Sakkinen <jarkko@kernel.org>, Kai Huang <kai.huang@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170205918069.398.17416852974013342906.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     4f812df8f37463767c2a74c2bd77de94acdb2be6
Gitweb:        https://git.kernel.org/tip/4f812df8f37463767c2a74c2bd77de94acdb2be6
Author:        Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
AuthorDate:    Thu, 05 Oct 2023 17:38:47 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 08 Dec 2023 10:05:27 -08:00

selftests/sgx: Remove redundant enclave base address save/restore

Remove redundant push/pop pair that stores and restores the enclave base
address in the test enclave, as it is never used after the pop and can
anyway be easily retrieved via the __encl_base symbol.

Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Acked-by: Kai Huang <kai.huang@intel.com>
Link: https://lore.kernel.org/all/20231005153854.25566-7-jo.vanbulck%40cs.kuleuven.be
---
 tools/testing/selftests/sgx/test_encl_bootstrap.S | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/selftests/sgx/test_encl_bootstrap.S b/tools/testing/selftests/sgx/test_encl_bootstrap.S
index 03ae0f5..e0ce993 100644
--- a/tools/testing/selftests/sgx/test_encl_bootstrap.S
+++ b/tools/testing/selftests/sgx/test_encl_bootstrap.S
@@ -55,12 +55,9 @@ encl_entry_core:
 	push	%rax
 
 	push	%rcx # push the address after EENTER
-	push	%rbx # push the enclave base address
 
 	call	encl_body
 
-	pop	%rbx # pop the enclave base address
-
 	/* Clear volatile GPRs, except RAX (EEXIT function). */
 	xor     %rcx, %rcx
 	xor     %rdx, %rdx

