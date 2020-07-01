Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D61A2105B1
	for <lists+linux-tip-commits@lfdr.de>; Wed,  1 Jul 2020 10:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbgGAIEz (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 1 Jul 2020 04:04:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36280 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728651AbgGAIEy (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 1 Jul 2020 04:04:54 -0400
Date:   Wed, 01 Jul 2020 08:04:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593590691;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A1GB6lJaLBvn/Nc11IVOZHD+1vLyvMjDqyYONBSbSqs=;
        b=HOEYjig1A6yd4rX0tXdikV6q7d7FNhoWiFjEBzrzwKW6l0T720ebhM9aHi5LPL8LQl2QDE
        0zVfY7MhEf0fL68SCMPjyYvKjV+zQP8p3oTMnvX9ukfkSnoCr8lIP6tyPzUr9KPQi/5oej
        DRxWYGX6PRIj4XMRI3/elZ498RJgj7ATPn7A6s4TKT5+4swUU4IzOfAFkacs2ewygwohXq
        grkYTbu5mmNaCy/HIPci9hdB8D4VfMyrb31/VcbjdFV1Sgn9l2k1TGBk6OxvB4uYwJXJrY
        3e3S9gQ3j7c+YYYGTMiY4WVcF69fLQotUI41ReNDZ617HOTaj5a262aak6G65w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593590691;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A1GB6lJaLBvn/Nc11IVOZHD+1vLyvMjDqyYONBSbSqs=;
        b=lA4Y4lYwTV7HJ4Qef6CokusRWiW/CXrXo9sToewPsqjAWCyltp7oV4kNLyhy7eYYCYvxEx
        9B9nKfh88i8ru0DA==
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] selftests/x86/syscall_nt: Clear weird flags after each test
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <907bfa5a42d4475b8245e18b67a04b13ca51ffdb.1593191971.git.luto@kernel.org>
References: <907bfa5a42d4475b8245e18b67a04b13ca51ffdb.1593191971.git.luto@kernel.org>
MIME-Version: 1.0
Message-ID: <159359069061.4006.13159564696561405198.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     a61fa2799ef9bf6c4f54cf7295036577cececc72
Gitweb:        https://git.kernel.org/tip/a61fa2799ef9bf6c4f54cf7295036577cececc72
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Fri, 26 Jun 2020 10:21:15 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 01 Jul 2020 10:00:26 +02:00

selftests/x86/syscall_nt: Clear weird flags after each test

Clear the weird flags before logging to improve strace output --
logging results while, say, TF is set does no one any favors.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/907bfa5a42d4475b8245e18b67a04b13ca51ffdb.1593191971.git.luto@kernel.org

---
 tools/testing/selftests/x86/syscall_nt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/x86/syscall_nt.c b/tools/testing/selftests/x86/syscall_nt.c
index f060534..5fc82b9 100644
--- a/tools/testing/selftests/x86/syscall_nt.c
+++ b/tools/testing/selftests/x86/syscall_nt.c
@@ -59,6 +59,7 @@ static void do_it(unsigned long extraflags)
 	set_eflags(get_eflags() | extraflags);
 	syscall(SYS_getpid);
 	flags = get_eflags();
+	set_eflags(X86_EFLAGS_IF | X86_EFLAGS_FIXED);
 	if ((flags & extraflags) == extraflags) {
 		printf("[OK]\tThe syscall worked and flags are still set\n");
 	} else {
