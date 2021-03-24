Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E371634757A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 24 Mar 2021 11:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235519AbhCXKJ0 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 24 Mar 2021 06:09:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39534 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235462AbhCXKI4 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 24 Mar 2021 06:08:56 -0400
Date:   Wed, 24 Mar 2021 10:08:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616580535;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LQ7kZl8uWLHshQ+GVvakwbz3p2Znk4AUiQGf7YJBHXM=;
        b=SiVjJiJjB/rtSCdGRyBp50sfW/BB/n6zPMSc+aRq1zNdTNY8SifL4+unu4CTgvpnqmecVQ
        EgjCd74XnLBmG0jETjusAAaATqwwKLvuKhvCOY4cp0eHbvDeSsNIW7m4tqe+S+zaGVuciA
        mTH+J5pEK0N7+TzbjCtcXou/RTdbK35cEFpSd0UHeKNQNDgs2NF1M3f0JwtSZ6/Xc+uVxw
        Jqu6RhxNsuRJ4Ew6tdsYJLinQlkuTU4YWnXxTkXeeLdsnu8QrPVXMRjxkBsYZf6hJ/jcrB
        Ik/Vu1j19D7VtJg0qNPt05qAjSjsr6cfcIxMBa+fMVsA+R3+2eC2FB5uueD4Jg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616580535;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LQ7kZl8uWLHshQ+GVvakwbz3p2Znk4AUiQGf7YJBHXM=;
        b=CVfdg7ydhMDVUjHCHRZ2cenX6xtE5zwBBliGrTrhWU/5zjhVOLrkz0HEA2fKq4p3aKhCt+
        c5H+f760IiqMUtDg==
From:   "tip-bot2 for Tianjia Zhang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] selftests/sgx: Use getauxval() to simplify test code
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Borislav Petkov <bp@suse.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210314111621.68428-1-tianjia.zhang@linux.alibaba.com>
References: <20210314111621.68428-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Message-ID: <161658053435.398.3465850106748524657.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     f33dece70e11ce82a09cb1ea2d7c32347b82c67e
Gitweb:        https://git.kernel.org/tip/f33dece70e11ce82a09cb1ea2d7c32347b82c67e
Author:        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
AuthorDate:    Sun, 14 Mar 2021 19:16:21 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 24 Mar 2021 10:59:09 +01:00

selftests/sgx: Use getauxval() to simplify test code

Use the library function getauxval() instead of a custom function to get
the base address of the vDSO.

 [ bp: Massage commit message. ]

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Link: https://lkml.kernel.org/r/20210314111621.68428-1-tianjia.zhang@linux.alibaba.com
---
 tools/testing/selftests/sgx/main.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index b117bb8..d304a40 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -15,6 +15,7 @@
 #include <sys/stat.h>
 #include <sys/time.h>
 #include <sys/types.h>
+#include <sys/auxv.h>
 #include "defines.h"
 #include "main.h"
 #include "../kselftest.h"
@@ -28,24 +29,6 @@ struct vdso_symtab {
 	Elf64_Word *elf_hashtab;
 };
 
-static void *vdso_get_base_addr(char *envp[])
-{
-	Elf64_auxv_t *auxv;
-	int i;
-
-	for (i = 0; envp[i]; i++)
-		;
-
-	auxv = (Elf64_auxv_t *)&envp[i + 1];
-
-	for (i = 0; auxv[i].a_type != AT_NULL; i++) {
-		if (auxv[i].a_type == AT_SYSINFO_EHDR)
-			return (void *)auxv[i].a_un.a_val;
-	}
-
-	return NULL;
-}
-
 static Elf64_Dyn *vdso_get_dyntab(void *addr)
 {
 	Elf64_Ehdr *ehdr = addr;
@@ -162,7 +145,7 @@ static int user_handler(long rdi, long rsi, long rdx, long ursp, long r8, long r
 	return 0;
 }
 
-int main(int argc, char *argv[], char *envp[])
+int main(int argc, char *argv[])
 {
 	struct sgx_enclave_run run;
 	struct vdso_symtab symtab;
@@ -203,7 +186,8 @@ int main(int argc, char *argv[], char *envp[])
 	memset(&run, 0, sizeof(run));
 	run.tcs = encl.encl_base;
 
-	addr = vdso_get_base_addr(envp);
+	/* Get vDSO base address */
+	addr = (void *)getauxval(AT_SYSINFO_EHDR);
 	if (!addr)
 		goto err;
 
