Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA8C52B1273
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Nov 2020 00:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgKLXGI (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 12 Nov 2020 18:06:08 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:47774 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbgKLXGI (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 12 Nov 2020 18:06:08 -0500
Date:   Thu, 12 Nov 2020 23:06:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605222365;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QTpmNCNqBmw3Yyz+3dNWgY5l4250Y0qHxE6RjNAhzs0=;
        b=XMjkHyeLiDBowGutTIbPmBpOQWN435u3gplAvtk2hvX4tKloXUC/cINpVguJOOCqwzOaGx
        8My7+OfL2DsVYd5WAIZdRzv8W+Z5LrsWShE52DYmy2mNzFxgDBziqFuUsUmhF+x77CV/y7
        AWZAld9atlHt2MjT4stHTk5q8v0J/V+GEE4N5Y60qHIufTWakBfmvp2pldFX4wCHU3stsH
        bj0ip8AntbIzaUTyrXUUq68CIVo0ftrNSeSlRW7KbBHz0cJS6rv8SVpFRiWe7slzHU098s
        zeDAzaRFf/axXH5C4fZoMxvgpsAtjLe4evr+rbGI1+gBpX6Rl2/QDXyDIiES1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605222365;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QTpmNCNqBmw3Yyz+3dNWgY5l4250Y0qHxE6RjNAhzs0=;
        b=Y8GqIe8KvLRJ91l1kdb4BJWMvXzKMHmFGzYGP5H6SbZCng/1mhFtv3EhUq8UdC0Os7Lde6
        8gCjzvbD/9BsFUBg==
From:   "tip-bot2 for Mike Travis" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/platform/uv: Fix copied UV5 output archtype
Cc:     Mike Travis <mike.travis@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steve Wahl <steve.wahl@hpe.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201111010418.82133-1-mike.travis@hpe.com>
References: <20201111010418.82133-1-mike.travis@hpe.com>
MIME-Version: 1.0
Message-ID: <160522236375.11244.9421056354118266795.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     77c7e1bc060deab6430f1dff5922ccd3093d9776
Gitweb:        https://git.kernel.org/tip/77c7e1bc060deab6430f1dff5922ccd3093d9776
Author:        Mike Travis <mike.travis@hpe.com>
AuthorDate:    Tue, 10 Nov 2020 19:04:18 -06:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 13 Nov 2020 00:00:31 +01:00

x86/platform/uv: Fix copied UV5 output archtype

A test shows that the output contains a space:
    # cat /proc/sgi_uv/archtype
    NSGI4 U/UVX

Remove that embedded space by copying the "trimmed" buffer instead of the
untrimmed input character list.  Use sizeof to remove size dependency on
copy out length.  Increase output buffer size by one character just in case
BIOS sends an 8 character string for archtype.

Fixes: 1e61f5a95f19 ("Add and decode Arch Type in UVsystab")
Signed-off-by: Mike Travis <mike.travis@hpe.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Link: https://lore.kernel.org/r/20201111010418.82133-1-mike.travis@hpe.com
---
 arch/x86/kernel/apic/x2apic_uv_x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 3115caa..1b98f8c 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -33,7 +33,7 @@ static union uvh_apicid		uvh_apicid;
 static int			uv_node_id;
 
 /* Unpack AT/OEM/TABLE ID's to be NULL terminated strings */
-static u8 uv_archtype[UV_AT_SIZE];
+static u8 uv_archtype[UV_AT_SIZE + 1];
 static u8 oem_id[ACPI_OEM_ID_SIZE + 1];
 static u8 oem_table_id[ACPI_OEM_TABLE_ID_SIZE + 1];
 
@@ -320,7 +320,7 @@ static int __init decode_arch_type(unsigned long ptr)
 
 	if (n > 0 && n < sizeof(uv_ate->archtype)) {
 		pr_info("UV: UVarchtype received from BIOS\n");
-		uv_stringify(UV_AT_SIZE, uv_archtype, uv_ate->archtype);
+		uv_stringify(sizeof(uv_archtype), uv_archtype, uv_ate->archtype);
 		return 1;
 	}
 	return 0;
@@ -378,7 +378,7 @@ static int __init uv_set_system_type(char *_oem_id, char *_oem_table_id)
 	if (!early_get_arch_type())
 
 		/* If not use OEM ID for UVarchtype */
-		uv_stringify(UV_AT_SIZE, uv_archtype, _oem_id);
+		uv_stringify(sizeof(uv_archtype), uv_archtype, oem_id);
 
 	/* Check if not hubbed */
 	if (strncmp(uv_archtype, "SGI", 3) != 0) {
