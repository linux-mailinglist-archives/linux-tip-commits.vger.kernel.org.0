Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8F337BB9D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 May 2021 13:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhELLRR (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 12 May 2021 07:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbhELLRQ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 12 May 2021 07:17:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75C9C061574;
        Wed, 12 May 2021 04:16:08 -0700 (PDT)
Date:   Wed, 12 May 2021 11:16:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620818167;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2xT0Mc7af26HMSTIFCC7kJJvKq8z50alSFBUKF2FZNY=;
        b=3CGW8u2NZ4o1bH9XCPFDE60GzNVZzytkGAYw2UAaNlhzw3N3AMCU6e4GfvgPQeeAm2iLpe
        8IGHCpCzQSx0MIPSDhfsUAG4ejkCio7NuW8bOFElkuEO5YFWge2qeK9pNqpuMJsBNE6nkW
        wF/+fdHZxOuEr0bG+tewajfN3DH/GRRQfbCJ+9XrBOKhWKSi10tRZC10+Ay2YifVaZMSKp
        Pmg6ePJaTpM5oU+GK/pu+lr/qbBUf59F6cV1gU9NQ5Q7NIrA0b4CysYk8GUWrxGpnqiFfv
        uSbDVo5SHBuMRV9C+pgMZJ7Zo/SlyLp+5XMlAE75A8gQGT/htKXzs3TlwwMY2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620818167;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2xT0Mc7af26HMSTIFCC7kJJvKq8z50alSFBUKF2FZNY=;
        b=VLp8EuLCUVaATwuSGGZM8DZX3yQhP7V3xQFM2WnGuIOP1X+Zs0bMna9wrAwaw4dGqXvB1q
        1Bk3cQZ+oKJ5FbCw==
From:   "tip-bot2 for Pavel Skripkin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/alternatives: Make the x86nops[] symbol static
Cc:     Pavel Skripkin <paskripkin@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210506190726.15575-1-paskripkin@gmail.com>
References: <20210506190726.15575-1-paskripkin@gmail.com>
MIME-Version: 1.0
Message-ID: <162081816689.29796.6774528668273911731.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     64e1f5872a8c3d80bce4686b4ab5dbc6e6bd30c5
Gitweb:        https://git.kernel.org/tip/64e1f5872a8c3d80bce4686b4ab5dbc6e6bd30c5
Author:        Pavel Skripkin <paskripkin@gmail.com>
AuthorDate:    Thu, 06 May 2021 22:07:26 +03:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 12 May 2021 12:22:56 +02:00

x86/alternatives: Make the x86nops[] symbol static

Sparse says:

  arch/x86/kernel/alternative.c:78:21: warning: symbol 'x86nops' was not declared. Should it be static?

Since x86nops[] is not used outside this file, Sparse is right and it can be made static.

Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210506190726.15575-1-paskripkin@gmail.com
---
 arch/x86/kernel/alternative.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 6974b51..75c752b 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -75,7 +75,7 @@ do {									\
 	}								\
 } while (0)
 
-const unsigned char x86nops[] =
+static const unsigned char x86nops[] =
 {
 	BYTES_NOP1,
 	BYTES_NOP2,
