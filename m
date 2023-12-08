Return-Path: <linux-tip-commits+bounces-1-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC0280ABB8
	for <lists+linux-tip-commits@lfdr.de>; Fri,  8 Dec 2023 19:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40802B20A87
	for <lists+linux-tip-commits@lfdr.de>; Fri,  8 Dec 2023 18:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5419F1F61F;
	Fri,  8 Dec 2023 18:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DKGBfBYk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tyA03ph3"
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCB5E9;
	Fri,  8 Dec 2023 10:12:58 -0800 (PST)
Date: Fri, 08 Dec 2023 18:12:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702059176;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=19gGXCN1G7w/Flhq+ObJ4E6Xtc/2cqhMNyyS5ds7U3c=;
	b=DKGBfBYk4iqAsUEKLMzPdUhHHgao/m6VbinAkCWUgI/dpUOI/tmBjurjaJpV7oRC/JVaj0
	KFb6x29ah0LHK/0N5WrtPWKApISH78UGOA3qZp1Eye4QUc6JBb6JBO++JnbZSnilokrzeW
	qGJIYvGLmcJIyoWQNphqbtSRsT3iepco4kEawLQDTj5wnaRJc8J6Gg3zO41pmrISBpVy1J
	C3Bk14j2OMlywRfELUA+eFy4r7AVA+MEBf7K+5mtPAdc/wuYHPEyLyQYClYR7RYbA5JhDS
	XzzsvV8Zn6Sj6OWPhPu6yHo2WvkksxurT+OqGliBt9o74FVYy/EaZYnIYhm6Ag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702059176;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=19gGXCN1G7w/Flhq+ObJ4E6Xtc/2cqhMNyyS5ds7U3c=;
	b=tyA03ph3/wdj3TCZ4CPLeu+SeXDOp/7IVTf6WCoCGOtxcl4TWbr250pnSqdz0QJ3jyHeiZ
	sHvUz51tgy/Be/AQ==
From: "tip-bot2 for Jo Van Bulck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] selftests/sgx: Discard unsupported ELF sections
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
Message-ID: <170205917625.398.13315444953275165354.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     ec44ca1e34bc3a9864a8c1bf8636066ec6d5d2e5
Gitweb:        https://git.kernel.org/tip/ec44ca1e34bc3a9864a8c1bf8636066ec6d5d2e5
Author:        Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
AuthorDate:    Thu, 05 Oct 2023 17:38:53 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 08 Dec 2023 10:05:28 -08:00

selftests/sgx: Discard unsupported ELF sections

Building the test enclave with -static-pie may produce a dynamic symbol
table, but this is not supported for enclaves and any relocations need to
happen manually (e.g., as for "encl_op_array"). Thus, opportunistically
discard ".dyn*" and ".gnu.hash" which the enclave loader cannot handle.

Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lore.kernel.org/all/20231005153854.25566-13-jo.vanbulck%40cs.kuleuven.be
---
 tools/testing/selftests/sgx/test_encl.lds | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/sgx/test_encl.lds b/tools/testing/selftests/sgx/test_encl.lds
index 333a3e7..ffe851a 100644
--- a/tools/testing/selftests/sgx/test_encl.lds
+++ b/tools/testing/selftests/sgx/test_encl.lds
@@ -33,6 +33,8 @@ SECTIONS
 		*(.note*)
 		*(.debug*)
 		*(.eh_frame*)
+		*(.dyn*)
+		*(.gnu.hash)
 	}
 }
 

