Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F67451D32
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Nov 2021 01:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349955AbhKPAZ6 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Nov 2021 19:25:58 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:47064 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350729AbhKOUZh (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Nov 2021 15:25:37 -0500
Date:   Mon, 15 Nov 2021 20:22:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637007749;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QIckYkIZEHGKX6glcQZn26++LWd/zb1l+hzOQfIPX4M=;
        b=U5+GoYpVNtHU2URuUWs2+3jsfWd3Aug0ncmygjMaKoGK1AxeOhLbwhLQ9X3O5OYeNs8z35
        zxtwnn01n+6TM00bcFzTYFym1mUrn9LcTyFZ/QnHEkNWRJ+2T/8k/PiVpb+lO4ZBsbtLEF
        JInP33EPydzCsrCQD5hx4eTJA3aDKTQtAoo6zGELBNT4NZl9wI17GB6L6JHpHC7xVwzgzD
        DjGufxoq4BSZRT6ZMqClukkgr/W/tKFelAhTRo43u9XgsyOpugw0VGCz3nubQGGborc+UO
        4MHtJUMXtjoqg+oGGKAOjrwrK6NATD55qpN9pBkNPsRR1J85evRp+50cImG5uA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637007749;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QIckYkIZEHGKX6glcQZn26++LWd/zb1l+hzOQfIPX4M=;
        b=YM3uEdSgB+x10/vHzf3YQuz28wCvaknMfnYnP34Hnb2AlGC+o/YKe2vvKGoLUZak2bxfZ4
        DVJtouVqrNFuAnDg==
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] selftests/sgx: Fix a benign linker warning
Cc:     Cedric Xing <cedric.xing@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cca0f8a81fc1e78af9bdbc6a88e0f9c37d82e53f2=2E16369?=
 =?utf-8?q?97631=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
References: =?utf-8?q?=3Cca0f8a81fc1e78af9bdbc6a88e0f9c37d82e53f2=2E163699?=
 =?utf-8?q?7631=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <163700774865.414.17082222045277684777.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     5064343fb155487362708bacc8c6ab9dc2c52bb8
Gitweb:        https://git.kernel.org/tip/5064343fb155487362708bacc8c6ab9dc2c52bb8
Author:        Sean Christopherson <sean.j.christopherson@intel.com>
AuthorDate:    Mon, 15 Nov 2021 10:35:14 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 15 Nov 2021 11:33:53 -08:00

selftests/sgx: Fix a benign linker warning

The enclave binary (test_encl.elf) is built with only three sections (tcs,
text, and data) as controlled by its custom linker script.

If gcc is built with "--enable-linker-build-id" (this appears to be a
common configuration even if it is by default off) then gcc
will pass "--build-id" to the linker that will prompt it (the linker) to
write unique bits identifying the linked file to a ".note.gnu.build-id"
section.

The section ".note.gnu.build-id" does not exist in the test enclave
resulting in the following warning emitted by the linker:

/usr/bin/ld: warning: .note.gnu.build-id section discarded, --build-id
ignored

The test enclave does not use the build id within the binary so fix the
warning by passing a build id of "none" to the linker that will disable the
setting from any earlier "--build-id" options and thus disable the attempt
to write the build id to a ".note.gnu.build-id" section that does not
exist.

Link: https://lore.kernel.org/linux-sgx/20191017030340.18301-2-sean.j.christopherson@intel.com/
Suggested-by: Cedric Xing <cedric.xing@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/ca0f8a81fc1e78af9bdbc6a88e0f9c37d82e53f2.1636997631.git.reinette.chatre@intel.com
---
 tools/testing/selftests/sgx/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/sgx/Makefile b/tools/testing/selftests/sgx/Makefile
index 7f12d55..2956584 100644
--- a/tools/testing/selftests/sgx/Makefile
+++ b/tools/testing/selftests/sgx/Makefile
@@ -45,7 +45,7 @@ $(OUTPUT)/sign_key.o: sign_key.S
 	$(CC) $(HOST_CFLAGS) -c $< -o $@
 
 $(OUTPUT)/test_encl.elf: test_encl.lds test_encl.c test_encl_bootstrap.S
-	$(CC) $(ENCL_CFLAGS) -T $^ -o $@
+	$(CC) $(ENCL_CFLAGS) -T $^ -o $@ -Wl,--build-id=none
 
 EXTRA_CLEAN := \
 	$(OUTPUT)/test_encl.elf \
