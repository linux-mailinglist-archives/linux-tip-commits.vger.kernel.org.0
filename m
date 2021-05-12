Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36ACD37BE09
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 May 2021 15:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbhELNVE (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 12 May 2021 09:21:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51732 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbhELNVC (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 12 May 2021 09:21:02 -0400
Date:   Wed, 12 May 2021 13:19:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620825593;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WPtHy0O3DJH8u9h9Da4vVCx09lKAVfFg5K1Wp/+urZ8=;
        b=VR+zwBs4aMw0c0ubGtOTvqNnEiwV6rrz3qxLe5Fa0/bJgqqOBehkmVWijDh533GkYHeKxx
        vyj63gRs4tAeeRCLqhL7mf0+xe5x9Amafxz3BFwHyDQvsbqsv77lCz4dxcojBRv7I2XoA1
        05eIoiYg8OM7EIg7zec76QmC2Nabb7oGLoOd3Vc43LR7N5tFjLqDPM1tQQTy3Pl2ZAoU8z
        xhUqnBa8e3MEXzX4XJh2cf5jNM6rNYhtMLRSd8ocFrO951dYd8lTl3ctoEZsO49D4xD7ei
        MkqYCv4mm/3F+oZRFAj1EarPnIkpvUorHMZa8bO5zmZjpyjTm8A9aDfI4InBjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620825593;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WPtHy0O3DJH8u9h9Da4vVCx09lKAVfFg5K1Wp/+urZ8=;
        b=wLn4BAFhaVD8BW4i6Z/O9neOSuCub61iAVAZBq/bQqLx9Te8iVJp3ImKRnPXI/pjvGISSl
        O0PEGtsHhqmcaQDQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86, objtool: Dont exclude arch/x86/realmode/
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210506194157.516200011@infradead.org>
References: <20210506194157.516200011@infradead.org>
MIME-Version: 1.0
Message-ID: <162082559265.29796.3486154504952053256.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     80870e6ece78ce67b91398db88fb6b92a178f574
Gitweb:        https://git.kernel.org/tip/80870e6ece78ce67b91398db88fb6b92a178f574
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 06 May 2021 21:33:54 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 12 May 2021 14:54:54 +02:00

x86, objtool: Dont exclude arch/x86/realmode/

Specifically, init.c uses jump_labels.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210506194157.516200011@infradead.org
---
 arch/x86/realmode/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/realmode/Makefile b/arch/x86/realmode/Makefile
index 6b1f3a4..a0b491a 100644
--- a/arch/x86/realmode/Makefile
+++ b/arch/x86/realmode/Makefile
@@ -10,7 +10,6 @@
 # Sanitizer runtimes are unavailable and cannot be linked here.
 KASAN_SANITIZE			:= n
 KCSAN_SANITIZE			:= n
-OBJECT_FILES_NON_STANDARD	:= y
 
 subdir- := rm
 
