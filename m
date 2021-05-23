Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38C6038DAD0
	for <lists+linux-tip-commits@lfdr.de>; Sun, 23 May 2021 12:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbhEWKGR (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 23 May 2021 06:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbhEWKGQ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 23 May 2021 06:06:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B5FC061574;
        Sun, 23 May 2021 03:04:50 -0700 (PDT)
Date:   Sun, 23 May 2021 10:04:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621764288;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=0tUYQHmDvtABAiPtAtlsPGT0mUUsqJITvqkUPcfWZA0=;
        b=PzQChSycs7AmstTmxqpvvpOWnNBzYT2nuiCaFqqCpFORb68VdE3V6yZqT6Bv9qmZF696bz
        glwUxKa2qGWLkORPrQoQ2SaLa5tYCUR9hjnAAaujfXpD43k9HcWGKAEr+CAiy473SARezy
        1Nao6lGXrBXqKrthpgh2Sye3AIDrec+pNMb24v6v0Uo6wfQ7djXNW1GLkb39EmeEfUW3Xh
        HXBdKqImh20agbcd9nDlNwjI1ff1uz2mLFb5WPTLYsoB0wkjXnOlnvGvJR3A/ltRMI7NNF
        k4sIhYRAq0xJs6sIHZ7QSF0nFmEZQpeO4SZvANfrtaAWLT4j9m+gnEE3odtAZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621764288;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=0tUYQHmDvtABAiPtAtlsPGT0mUUsqJITvqkUPcfWZA0=;
        b=aTKJURR8XExKm2A2qiaBXBtKGdJm5dlZdkj3CwUzNJkfiC1lYRZP1V5U4iqSpmMoG+mvt1
        H7MgVKFap6PzsWAQ==
From:   "tip-bot2 for Heikki Krogerus" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/core] efi/apple-properties: Handle device properties with
 software node API
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162176428803.29796.1147855161001088880.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/core branch of tip:

Commit-ID:     55fc610c8cdae353737dbc2d59febd3c1a697095
Gitweb:        https://git.kernel.org/tip/55fc610c8cdae353737dbc2d59febd3c1a697095
Author:        Heikki Krogerus <heikki.krogerus@linux.intel.com>
AuthorDate:    Thu, 04 Mar 2021 11:28:37 +03:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Sat, 22 May 2021 14:06:59 +02:00

efi/apple-properties: Handle device properties with software node API

The old device property API is going to be removed.
Replacing the device_add_properties() call with the software
node API equivalent, device_create_managed_software_node().

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Acked-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/apple-properties.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/apple-properties.c b/drivers/firmware/efi/apple-properties.c
index e192648..4c3201e 100644
--- a/drivers/firmware/efi/apple-properties.c
+++ b/drivers/firmware/efi/apple-properties.c
@@ -157,7 +157,7 @@ static int __init unmarshal_devices(struct properties_header *properties)
 		if (!entry[0].name)
 			goto skip_device;
 
-		ret = device_add_properties(dev, entry); /* makes deep copy */
+		ret = device_create_managed_software_node(dev, entry, NULL);
 		if (ret)
 			dev_err(dev, "error %d assigning properties\n", ret);
 
