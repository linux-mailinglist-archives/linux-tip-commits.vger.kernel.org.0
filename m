Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7970B27E04C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Sep 2020 07:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbgI3F1y (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Sep 2020 01:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbgI3F1y (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Sep 2020 01:27:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9A5C061755;
        Tue, 29 Sep 2020 22:27:54 -0700 (PDT)
Date:   Wed, 30 Sep 2020 05:27:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601443672;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F2+fY2dZKNP/aZp/qnC0NTp4QDgQaVtIJr4EJtbm23c=;
        b=OWyYnDAlHvDdjvu/p8b9jM2YZIr+NBBobJOjXGLNmuJQnu/EYtvyUHh0rGr6pk1akuXQ6i
        XV2QE0lHpzlV16xofuehXqNdjSStpRJubKlNH1Ix9Gt5fBfUpQGeg2hINUQDSnZ+nSo3We
        L3N8jZ5i2qHoKMb4XxZglqdRR0P66AEBPv9jPlZjBs4mm0+s2qiTeS8UHr0U6hWngud4Fd
        BsbdS2kGFN9bccE6fZQrt05cvlA9I07Ec+PP0FD0kwshxsu6voL0dVpb3jZ5KYmz6YGzMd
        0JczSBNjcdUZOhRKcUYBl+7OPWKMnL7toym5/knJte8MXlh/IWiElcTAuWB3Jw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601443672;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F2+fY2dZKNP/aZp/qnC0NTp4QDgQaVtIJr4EJtbm23c=;
        b=VR7IUua9b7hLlL9RGdQfyUHa9mZ/6J3Ghf7oEpolc5MXwZhO75AHtZlJ6Qza0VG4lWLNt9
        NYv2pzriOzxvJpBw==
From:   "tip-bot2 for Tian Tao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] efi: Delete deprecated parameter comments
Cc:     Tian Tao <tiantao6@hisilicon.com>,
        Ard Biesheuvel <ardb@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1600914018-12697-1-git-send-email-tiantao6@hisilicon.com>
References: <1600914018-12697-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Message-ID: <160144367200.7002.14907924578104961122.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/urgent branch of tip:

Commit-ID:     f5344e5d6ccb9ddf377202690a135bc64607c621
Gitweb:        https://git.kernel.org/tip/f5344e5d6ccb9ddf377202690a135bc64607c621
Author:        Tian Tao <tiantao6@hisilicon.com>
AuthorDate:    Thu, 24 Sep 2020 10:20:18 +08:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Fri, 25 Sep 2020 23:29:04 +02:00

efi: Delete deprecated parameter comments

Delete deprecated parameter comments to  fix warnings reported by make
W=1.
drivers/firmware/efi/vars.c:428: warning: Excess function parameter
'atomic' description in 'efivar_init'

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
Link: https://lore.kernel.org/r/1600914018-12697-1-git-send-email-tiantao6@hisilicon.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/vars.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
index 973eef2..274b0ee 100644
--- a/drivers/firmware/efi/vars.c
+++ b/drivers/firmware/efi/vars.c
@@ -414,7 +414,6 @@ static void dup_variable_bug(efi_char16_t *str16, efi_guid_t *vendor_guid,
  * efivar_init - build the initial list of EFI variables
  * @func: callback function to invoke for every variable
  * @data: function-specific data to pass to @func
- * @atomic: do we need to execute the @func-loop atomically?
  * @duplicates: error if we encounter duplicates on @head?
  * @head: initialised head of variable list
  *
