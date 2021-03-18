Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18C683402CC
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Mar 2021 11:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhCRKKQ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 18 Mar 2021 06:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhCRKJs (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 18 Mar 2021 06:09:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8D3C06174A;
        Thu, 18 Mar 2021 03:09:47 -0700 (PDT)
Date:   Thu, 18 Mar 2021 10:09:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616062185;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1RfqsN4pjQvnixC1LIKDGg9h4LEX2+AkMIT8KtYd68w=;
        b=CqLIN3xzuPVmH174EkL3JaZWb0hmcU6aSjR1WNvv0+YH58MDJFajP4fGbNkE05zWMFnkvT
        AD5QehMZPVEd1NcvB5SictYGExAn15HMtmXfQqRbEfUHq1GZhzReC81QWcVSG4umSA+8IR
        bLtw3M4pD7jkS9/l3mdzRIOZ4+vH5FM3niVxsx3MSxqvnESquXNQQ0Sa+Q7r5MXBMIiT5N
        ixsLPxcJcrCWGw2sE4lEKrw2S70hm7s6AxLLoPJIAr5m9Eh+wVkVSdkOFnEQ26LQYo3A/O
        WzOqUgockwFUxNHTQp6fMiaouLs7/zLy5m7B3SeVKpfQUG2P9fjhfc6XVkU3vw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616062185;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1RfqsN4pjQvnixC1LIKDGg9h4LEX2+AkMIT8KtYd68w=;
        b=4G+D47+6xlsIkCt2FOEY7GxazR+AvCCIyBFxIQTibpn7FwT0Pcsq5QuXz6a27sy9oDQ9ub
        FRiUFUG8z+UOhcBg==
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] selftests/x86: Add a missing .note.GNU-stack section
 to thunks_32.S
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <487ed5348a43c031b816fa7e9efedb75dc324299.1614877299.git.luto@kernel.org>
References: <487ed5348a43c031b816fa7e9efedb75dc324299.1614877299.git.luto@kernel.org>
MIME-Version: 1.0
Message-ID: <161606218445.398.14725807693890108247.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     f706bb59204ba1c47e896b456c97977fc97b7964
Gitweb:        https://git.kernel.org/tip/f706bb59204ba1c47e896b456c97977fc97b7964
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Thu, 04 Mar 2021 09:01:55 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 18 Mar 2021 11:05:14 +01:00

selftests/x86: Add a missing .note.GNU-stack section to thunks_32.S

test_syscall_vdso_32 ended up with an executable stacks because the asm
was missing the annotation that says that it is modern and doesn't need
an executable stack. Add the annotation.

This was missed in commit aeaaf005da1d ("selftests/x86: Add missing
.note.GNU-stack sections").

Fixes: aeaaf005da1d ("selftests/x86: Add missing .note.GNU-stack sections")
Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/487ed5348a43c031b816fa7e9efedb75dc324299.1614877299.git.luto@kernel.org
---
 tools/testing/selftests/x86/thunks_32.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/x86/thunks_32.S b/tools/testing/selftests/x86/thunks_32.S
index a71d92d..f3f56e6 100644
--- a/tools/testing/selftests/x86/thunks_32.S
+++ b/tools/testing/selftests/x86/thunks_32.S
@@ -45,3 +45,5 @@ call64_from_32:
 	ret
 
 .size call64_from_32, .-call64_from_32
+
+.section .note.GNU-stack,"",%progbits
