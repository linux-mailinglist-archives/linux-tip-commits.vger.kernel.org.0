Return-Path: <linux-tip-commits+bounces-1-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B23A80ABF4
	for <lists+linux-tip-commits@lfdr.de>; Fri,  8 Dec 2023 19:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCB011C2089B
	for <lists+linux-tip-commits@lfdr.de>; Fri,  8 Dec 2023 18:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537A141C82;
	Fri,  8 Dec 2023 18:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LH3Rzsls";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EzL71+T5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD0E84;
	Fri,  8 Dec 2023 10:21:21 -0800 (PST)
Date: Fri, 08 Dec 2023 18:21:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702059679;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=rl/u+AHVkXYVw7Am514fHW33Ua/oZNkO29uc1iwBl68=;
	b=LH3RzslsFm+94r1TWDQ0IDpO80KOcDzKH2l2oG0x7ZWmAOzKS/swiEwuf86w4dclHsAFyK
	yacse5vB/xOFwIcMg2wPuj6nzL4aO6ke8Qe2NVJv71ZHTTtSplZfC0L488rZA3hKdN7m6v
	ccT5hHYMGV3hS0W70Kfihu0VnJ+EhNk7lH2g5+MQ7qdWFdS+uyCxWwR+bjdsDYo7T1A8uM
	a1QvxGZMXrKj41MS/+O+cawT+KBLa9Ot4dPAX3/3VHTwWsHhSYmff9raw/hD9TfJUmu9Fw
	JgZTRcuzgPlU46WUgn+mN1Uf/EKd4vqFvt70bdP7GdfNl7TKfXgzvhAYzp2z/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702059679;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=rl/u+AHVkXYVw7Am514fHW33Ua/oZNkO29uc1iwBl68=;
	b=EzL71+T5A2f2WsDNIIrWruis+ooSXrGjIADrAk6X3YPeENdO6+wB9vt2XtjNdEbzUZg+WT
	/tPYIpKRL4xDf/Ag==
From: "tip-bot2 for Zhao Mengmeng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] selftests/sgx: Skip non X86_64 platform
Cc: Zhao Mengmeng <zhaomengmeng@kylinos.cn>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Jarkko Sakkinen <jarkko@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170205967894.398.11030924595049592850.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     981cf568a8644161c2f15c02278ebc2834b51ba6
Gitweb:        https://git.kernel.org/tip/981cf568a8644161c2f15c02278ebc2834b51ba6
Author:        Zhao Mengmeng <zhaomengmeng@kylinos.cn>
AuthorDate:    Tue, 05 Dec 2023 21:56:05 -05:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 08 Dec 2023 10:08:17 -08:00

selftests/sgx: Skip non X86_64 platform

When building whole selftests on arm64, rsync gives an erorr about sgx:

rsync: [sender] link_stat "/root/linux-next/tools/testing/selftests/sgx/test_encl.elf" failed: No such file or directory (2)
rsync error: some files/attrs were not transferred (see previous errors) (code 23) at main.c(1327) [sender=3.2.5]

The root casue is sgx only used on X86_64, and shall be skipped on other
platforms.

Fix this by moving TEST_CUSTOM_PROGS and TEST_FILES inside the if check,
then the build result will be "Skipping non-existent dir: sgx".

Fixes: 2adcba79e69d ("selftests/x86: Add a selftest for SGX")
Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lore.kernel.org/all/20231206025605.3965302-1-zhaomzhao%40126.com
---
 tools/testing/selftests/sgx/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/sgx/Makefile b/tools/testing/selftests/sgx/Makefile
index 8d2ba6a..867f88c 100644
--- a/tools/testing/selftests/sgx/Makefile
+++ b/tools/testing/selftests/sgx/Makefile
@@ -18,10 +18,10 @@ ENCL_CFLAGS += -Wall -Werror -static-pie -nostdlib -ffreestanding -fPIE \
 	       -fno-stack-protector -mrdrnd $(INCLUDES)
 ENCL_LDFLAGS := -Wl,-T,test_encl.lds,--build-id=none
 
+ifeq ($(CAN_BUILD_X86_64), 1)
 TEST_CUSTOM_PROGS := $(OUTPUT)/test_sgx
 TEST_FILES := $(OUTPUT)/test_encl.elf
 
-ifeq ($(CAN_BUILD_X86_64), 1)
 all: $(TEST_CUSTOM_PROGS) $(OUTPUT)/test_encl.elf
 endif
 

