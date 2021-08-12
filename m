Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD9883EA766
	for <lists+linux-tip-commits@lfdr.de>; Thu, 12 Aug 2021 17:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236596AbhHLPTf (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 12 Aug 2021 11:19:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59206 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235613AbhHLPTe (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 12 Aug 2021 11:19:34 -0400
Date:   Thu, 12 Aug 2021 15:19:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628781548;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V34GEmeJhrmpBln2XLTU/+83lUZ0Gkvd5BCyv+3tI18=;
        b=RuwHP8+90y6nvwoI6rhY1t4oM5O5MbykHNKngkdMh24LxG3vBu8HnJ+yDBfrLM6SFEPVUF
        V9nas9D5bvQLbyKUJNzql7t1PiFYgtbvvzE6qguROdgoMmdpyrQ5Yt9mPx3nqar48VAfPS
        dNKL8u17tEIv6spgAKI04TgGJdpFsop+ivdgeYlzqwlCHTYsqXmUJ/+JdH3Ej+aLEWgLPd
        de+SPbd6ilAaFhtH0FBQPWB8+55JBHYGpr2OjGX+Sh3uHeCHhG9NlOEAzQvcYnjVcgrOWB
        PM5zie+K7b+nIcjg0CSeKfUW+D5sLlzt6iECVSfY5NYv8gt4hIpPygBqzKlVZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628781548;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V34GEmeJhrmpBln2XLTU/+83lUZ0Gkvd5BCyv+3tI18=;
        b=ZZX/m6X7FAyNPzO1CILXOVne4xCWMVP/rZ8eGy99/ih1XVhxf2UU5r11Wl3tI67cZzCkpT
        oJwrUi6gA5GaKsDg==
From:   "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/tools: Fix objdump version check again
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210731000146.2720-1-rdunlap@infradead.org>
References: <20210731000146.2720-1-rdunlap@infradead.org>
MIME-Version: 1.0
Message-ID: <162878154758.395.4059560755319851621.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     839ad22f755132838f406751439363c07272ad87
Gitweb:        https://git.kernel.org/tip/839ad22f755132838f406751439363c07272ad87
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Fri, 30 Jul 2021 17:01:46 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 12 Aug 2021 17:17:25 +02:00

x86/tools: Fix objdump version check again

Skip (omit) any version string info that is parenthesized.

Warning: objdump version 15) is older than 2.19
Warning: Skipping posttest.

where 'objdump -v' says:
GNU objdump (GNU Binutils; SUSE Linux Enterprise 15) 2.35.1.20201123-7.18

Fixes: 8bee738bb1979 ("x86: Fix objdump version check in chkobjdump.awk for different formats.")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Link: https://lore.kernel.org/r/20210731000146.2720-1-rdunlap@infradead.org

---
 arch/x86/tools/chkobjdump.awk | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/tools/chkobjdump.awk b/arch/x86/tools/chkobjdump.awk
index fd1ab80..a4cf678 100644
--- a/arch/x86/tools/chkobjdump.awk
+++ b/arch/x86/tools/chkobjdump.awk
@@ -10,6 +10,7 @@ BEGIN {
 
 /^GNU objdump/ {
 	verstr = ""
+	gsub(/\(.*\)/, "");
 	for (i = 3; i <= NF; i++)
 		if (match($(i), "^[0-9]")) {
 			verstr = $(i);
