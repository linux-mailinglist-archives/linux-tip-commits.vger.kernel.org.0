Return-Path: <linux-tip-commits+bounces-1-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 292DC80ABBE
	for <lists+linux-tip-commits@lfdr.de>; Fri,  8 Dec 2023 19:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D361C1F210DC
	for <lists+linux-tip-commits@lfdr.de>; Fri,  8 Dec 2023 18:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A44E3B189;
	Fri,  8 Dec 2023 18:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NvuCypa6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VLCdbRZb"
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1F4E9;
	Fri,  8 Dec 2023 10:13:03 -0800 (PST)
Date: Fri, 08 Dec 2023 18:13:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702059182;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=JgRl1YckNu9AO65EXo8Bm075gAidFqIf9saLES6tuQE=;
	b=NvuCypa6ECU3uFtOiIQ6LVTsB142ORjYQLiX8vKY9mW+dwJGswDGx6YKwfPWPYmHnhcTkk
	zgYjXt/RGs2X1VJeB+TvsfUFD+E4aQ2g/YgkRuzrNHacft84YhlbUTUF/TW6QvrmMVJ0or
	12n05BkeFXUD8Tqshvmvj9COjq63T8pAXU8GtzRv6m8jqNdXHL2/WW9gl/P6wlChnb2Ufd
	puvnK58JO2wLe9jMDTn3mtys9CsQ0IjoTL8ClwPt+XjqZvttac1hbFBzH8vi9IqWluwBtx
	uWWLq/zyzLElkS9OXe0Byl/iT3lAFnM+MHlLsFBso9AA/pcNwZv2Gena6JDhJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702059182;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=JgRl1YckNu9AO65EXo8Bm075gAidFqIf9saLES6tuQE=;
	b=VLCdbRZbcNsL2u6afzsgQRjrrJBs3ugMIc+PYBnfoq7TOgnwpDPWo5wdUtw4wC8/A+nm9f
	/RdJIuLWmpof3aDg==
From: "tip-bot2 for Jo Van Bulck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] selftests/sgx: Specify freestanding environment for
 enclave compilation
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
Message-ID: <170205918152.398.15533995692034132041.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     304b259e63b94c4f825e0648b33b15f8962955c7
Gitweb:        https://git.kernel.org/tip/304b259e63b94c4f825e0648b33b15f8962955c7
Author:        Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
AuthorDate:    Thu, 05 Oct 2023 17:38:46 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 08 Dec 2023 10:05:27 -08:00

selftests/sgx: Specify freestanding environment for enclave compilation

Use -ffreestanding to assert the enclave compilation targets a
freestanding environment (i.e., without "main" or standard libraries).
This fixes clang reporting "undefined reference to `memset'" after
erroneously optimizing away the provided memset/memcpy implementations.

Still need to instruct the linker from using standard system startup
functions, but drop -nostartfiles as it is implied by -nostdlib.

Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Acked-by: Kai Huang <kai.huang@intel.com>
Link: https://lore.kernel.org/all/20231005153854.25566-6-jo.vanbulck%40cs.kuleuven.be
---
 tools/testing/selftests/sgx/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/sgx/Makefile b/tools/testing/selftests/sgx/Makefile
index dcdd04b..7eb890b 100644
--- a/tools/testing/selftests/sgx/Makefile
+++ b/tools/testing/selftests/sgx/Makefile
@@ -14,7 +14,7 @@ endif
 INCLUDES := -I$(top_srcdir)/tools/include
 HOST_CFLAGS := -Wall -Werror -g $(INCLUDES) -fPIC
 HOST_LDFLAGS := -z noexecstack -lcrypto
-ENCL_CFLAGS += -Wall -Werror -static -nostdlib -nostartfiles -fPIC \
+ENCL_CFLAGS += -Wall -Werror -static -nostdlib -ffreestanding -fPIC \
 	       -fno-stack-protector -mrdrnd $(INCLUDES)
 ENCL_LDFLAGS := -Wl,-T,test_encl.lds,--build-id=none
 

