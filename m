Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9D95311D6F
	for <lists+linux-tip-commits@lfdr.de>; Sat,  6 Feb 2021 14:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhBFNUF (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 6 Feb 2021 08:20:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbhBFNUA (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 6 Feb 2021 08:20:00 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5B1C06174A;
        Sat,  6 Feb 2021 05:19:20 -0800 (PST)
Date:   Sat, 06 Feb 2021 13:19:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612617558;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YdhW8H6qMtBR3dhPjNOCZRv4mtqbJgbehBwMCpjdRto=;
        b=0aQZF0jANt5pyjB0XcpH6MWrRgSDKFh9eO0QhFUz+X13NSRhZLF8/2w+Vh75Mh8N78PYv4
        8okU2qVRARTIyLkjvqbqsRgF9tCdTnXcMFDeZyX5R6ONMR3vcY5OGqqubopKlKhmKm5x14
        +4tDMfZvqVMA1TJb8MbLi3yAO59O/+awj1d0aWYe2lhLZtPCykpjqMImKrEpHJft2vZVlq
        c83CFJ2mfvZZNEASTXPpEqvC8j259xIU/8sJuRPzOY8k93F2exGyszMJAclQ7WnCAiJMGf
        m61tgR8dMyw0r1XYRxUHyOKY6wsvyv2sx8fJkP9FDPUOanz52MqQF+JW5f7dlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612617558;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YdhW8H6qMtBR3dhPjNOCZRv4mtqbJgbehBwMCpjdRto=;
        b=wtxWxzTmp9C0wOnlhVhgy0u7VetV+HsnOz2XJHP8Wk7/UZ6qxZtwYSRwlnQ98s6AcaOPtI
        nqBbM79DZAVvrRCg==
From:   "tip-bot2 for Jarkko Sakkinen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] MAINTAINERS: Add Dave Hansen as reviewer for INTEL SGX
Cc:     Jarkko Sakkinen <jarkko@kernel.org>, Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210205151546.144810-1-jarkko@kernel.org>
References: <20210205151546.144810-1-jarkko@kernel.org>
MIME-Version: 1.0
Message-ID: <161261755749.23325.11866851026791658905.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     848477782bfa2b6aec738045246abd6cd104006c
Gitweb:        https://git.kernel.org/tip/848477782bfa2b6aec738045246abd6cd104006c
Author:        Jarkko Sakkinen <jarkko@kernel.org>
AuthorDate:    Fri, 05 Feb 2021 17:15:44 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sat, 06 Feb 2021 14:15:27 +01:00

MAINTAINERS: Add Dave Hansen as reviewer for INTEL SGX

Add Dave as reviewer for INTEL SGX patches.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/20210205151546.144810-1-jarkko@kernel.org
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5b66de2..41b78e2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9227,6 +9227,7 @@ F:	include/linux/tboot.h
 
 INTEL SGX
 M:	Jarkko Sakkinen <jarkko@kernel.org>
+R:	Dave Hansen <dave.hansen@linux.intel.com>
 L:	linux-sgx@vger.kernel.org
 S:	Supported
 Q:	https://patchwork.kernel.org/project/intel-sgx/list/
