Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 948FA2C6A25
	for <lists+linux-tip-commits@lfdr.de>; Fri, 27 Nov 2020 17:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731746AbgK0Qtc (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 27 Nov 2020 11:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731612AbgK0Qt2 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 27 Nov 2020 11:49:28 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB10C0613D1;
        Fri, 27 Nov 2020 08:49:28 -0800 (PST)
Date:   Fri, 27 Nov 2020 16:49:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606495766;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hknGfpaZlk4fYNbaScezbL+jgcw5gCrH3olnhnnpX/A=;
        b=yaXSBCoh6+4bhhdgb4AG5ubmnpqPLZkrbMVOLOI8soqlDlt7pTG2HROAq04fRJbB4Qn8e6
        q4o8QQnugW+XwTlG7NZLgmtYyb+rJIqB7gOLq2FtENVFS5QU5O9GEOrc3FVRRbM75nOpEl
        kbgTF3Ejnt/LWVRu/UZjIgPPYlya2rl/c+5oeGU8LS9kr2jT29OpGwpy//o8ZduJmCWBRi
        Sgq1sEOK/pJx9Bxw1phVDoQeUjbs4IvC+tseFasVVT+UkeyNqvF7AOlcz0hCsINgjVO+q1
        V9YpLrbmN2HCgaGgODlY6sudop5J/rVIAL9ITLQErKAX36pz/0FBQ00KHukKwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606495766;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hknGfpaZlk4fYNbaScezbL+jgcw5gCrH3olnhnnpX/A=;
        b=t6p9N56U6Vir9yJx1RV5bvXyJQJ/mz+SsILBX6fWS5dNsJcq2Ltw7kv28pxNcuk5Y9n8fP
        N58ZcG3Xz3YQ+/DA==
From:   tip-bot2 for Amadeusz =?utf-8?q?S=C5=82awi=C5=84ski?= 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] efi/efivars: Set generic ops before loading SSDT
Cc:     amadeuszx.slawinski@linux.intel.com,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201123172817.124146-1-amadeuszx.slawinski@linux.intel.com>
References: <20201123172817.124146-1-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Message-ID: <160649576626.3364.8890840511181549442.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/urgent branch of tip:

Commit-ID:     50bdcf047503e30126327d0be4f0ad7337106d68
Gitweb:        https://git.kernel.org/tip/50bdcf047503e30126327d0be4f0ad73371=
06d68
Author:        Amadeusz S=C5=82awi=C5=84ski <amadeuszx.slawinski@linux.intel.=
com>
AuthorDate:    Mon, 23 Nov 2020 12:28:17 -05:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Wed, 25 Nov 2020 16:55:02 +01:00

efi/efivars: Set generic ops before loading SSDT

Efivars allows for overriding of SSDT tables, however starting with
commit

  bf67fad19e493b ("efi: Use more granular check for availability for variable=
 services")

this use case is broken. When loading SSDT generic ops should be set
first, however mentioned commit reversed order of operations. Fix this
by restoring original order of operations.

Fixes: bf67fad19e493b ("efi: Use more granular check for availability for var=
iable services")
Signed-off-by: Amadeusz S=C5=82awi=C5=84ski <amadeuszx.slawinski@linux.intel.=
com>
Link: https://lore.kernel.org/r/20201123172817.124146-1-amadeuszx.slawinski@l=
inux.intel.com
Tested-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/efi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 5e5480a..6c6eec0 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -390,10 +390,10 @@ static int __init efisubsys_init(void)
=20
 	if (efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE |
 				      EFI_RT_SUPPORTED_GET_NEXT_VARIABLE_NAME)) {
-		efivar_ssdt_load();
 		error =3D generic_ops_register();
 		if (error)
 			goto err_put;
+		efivar_ssdt_load();
 		platform_device_register_simple("efivars", 0, NULL, 0);
 	}
=20
