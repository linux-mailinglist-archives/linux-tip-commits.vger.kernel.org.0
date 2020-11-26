Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6442B2C5BE1
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Nov 2020 19:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404913AbgKZSUt (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 26 Nov 2020 13:20:49 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58308 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404714AbgKZSUs (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 26 Nov 2020 13:20:48 -0500
Date:   Thu, 26 Nov 2020 18:20:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606414845;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WcBojW1MpMdUYdNJOblayB41lZcR7IhpbhfLUxWY5DU=;
        b=irvjhRK6bDvncbm8l3MedXOwjq3UJP2Don4eQZk2tq3nQ8EchYsza6/gAikpVUmP9HMy+M
        ZPPirabUSOdnhYIqJ3ZNVr1Ex+I6e1kbld05pZ9t7gN6jr4oPVuLJBQqsTy270uDJUElH5
        lkx1t6AZ0zFbN3MIcTSNL8n4kiGhkKbq30IIFHYJO1wRUNUAKB+lzfam04W5flZYicbIqc
        vRwcLxmDLF4FPHYnQPTVFXPbAK3DZN3OA3t8FH8BKYaQblu33E7SYngivUg9S3pq5cFFKK
        SekknsRKs2dyWU1JGggL/gTkxdNAkmRbU+frH+ESGW0ddA4fjdBE6+nCS4mbfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606414845;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WcBojW1MpMdUYdNJOblayB41lZcR7IhpbhfLUxWY5DU=;
        b=F0MTuZ9N9kukFUKfk+28SXMFnbx5Wh4ae79wMthyZz/i1uMBeN4XPg8ihbHffvXPbaBxH1
        gfT6FSUr5dCBJRBA==
From:   "tip-bot2 for Justin Ernst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/uv: Update ABI documentation of
 /sys/firmware/sgi_uv/
Cc:     Justin Ernst <justin.ernst@hpe.com>, Borislav Petkov <bp@suse.de>,
        Steve Wahl <steve.wahl@hpe.com>,
        Hans de Goede <hdegoede@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201125175444.279074-5-justin.ernst@hpe.com>
References: <20201125175444.279074-5-justin.ernst@hpe.com>
MIME-Version: 1.0
Message-ID: <160641484474.3364.10055711699697640990.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     7ac2f1017115ece5288465da2906ad23b8b07a65
Gitweb:        https://git.kernel.org/tip/7ac2f1017115ece5288465da2906ad23b8b07a65
Author:        Justin Ernst <justin.ernst@hpe.com>
AuthorDate:    Wed, 25 Nov 2020 11:54:43 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 26 Nov 2020 17:16:45 +01:00

x86/platform/uv: Update ABI documentation of /sys/firmware/sgi_uv/

Update the ABI documentation to describe the sysfs interface provided by
the new uv_sysfs platform driver.

Signed-off-by: Justin Ernst <justin.ernst@hpe.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Acked-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lkml.kernel.org/r/20201125175444.279074-5-justin.ernst@hpe.com
---
 Documentation/ABI/testing/sysfs-firmware-sgi_uv | 141 +++++++++++++--
 1 file changed, 127 insertions(+), 14 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-firmware-sgi_uv b/Documentation/ABI/testing/sysfs-firmware-sgi_uv
index 66800ba..50e25ce 100644
--- a/Documentation/ABI/testing/sysfs-firmware-sgi_uv
+++ b/Documentation/ABI/testing/sysfs-firmware-sgi_uv
@@ -1,27 +1,140 @@
 What:		/sys/firmware/sgi_uv/
-Date:		August 2008
-Contact:	Russ Anderson <rja@sgi.com>
+Date:		September 2020
+Contact:	Justin Ernst <justin.ernst@hpe.com>
 Description:
 		The /sys/firmware/sgi_uv directory contains information
-		about the SGI UV platform.
+		about the UV platform.
 
-		Under that directory are a number of files::
+		Under that directory are a number of read-only attributes:
 
 			partition_id
 			coherence_id
+			uv_type
 
 		The partition_id entry contains the partition id.
-		SGI UV systems can be partitioned into multiple physical
+		UV systems can be partitioned into multiple physical
 		machines, which each partition running a unique copy
-		of the operating system.  Each partition will have a unique
-		partition id.  To display the partition id, use the command::
-
-			cat /sys/firmware/sgi_uv/partition_id
+		of the operating system. Each partition will have a unique
+		partition id.
 
 		The coherence_id entry contains the coherence id.
-		A partitioned SGI UV system can have one or more coherence
-		domain.  The coherence id indicates which coherence domain
-		this partition is in.  To display the coherence id, use the
-		command::
+		A partitioned UV system can have one or more coherence
+		domains. The coherence id indicates which coherence domain
+		this partition is in.
+
+		The uv_type entry contains the hub revision number.
+		This value can be used to identify the UV system version:
+			"3.0" = UV2
+			"5.0" = UV3
+			"7.0" = UV4
+			"7.1" = UV4a
+			"9.0" = UV5
+
+		The /sys/firmware/sgi_uv directory also contains two directories:
+
+			hubs/
+			pcibuses/
+
+		The hubs directory contains a number of hub objects, each representing
+		a UV Hub visible to the BIOS. Each hub object's name is appended by a
+		unique ordinal value (ex. /sys/firmware/sgi_uv/hubs/hub_5)
+
+		Each hub object directory contains a number of read-only attributes:
+
+			cnode
+			location
+			name
+			nasid
+			shared
+			this_partition
+
+		The cnode entry contains the cnode number of the corresponding hub.
+		If a cnode value is not applicable, the value returned will be -1.
+
+		The location entry contains the location string of the corresponding hub.
+		This value is used to physically identify a hub within a system.
+
+		The name entry contains the name of the corresponding hub. This name can
+		be two variants:
+			"UVHub x.x" = A 'node' ASIC, connecting a CPU to the interconnect
+				fabric. The 'x.x' value represents the ASIC revision.
+				(ex. 'UVHub 5.0')
+			"NLxRouter" = A 'router ASIC, only connecting other ASICs to
+				the interconnect fabric. The 'x' value representing
+				the fabric technology version. (ex. 'NL8Router')
+
+		The nasid entry contains the nasid number of the corresponding hub.
+		If a nasid value is not applicable, the value returned will be -1.
+
+		The shared entry contains a boolean value describing whether the
+		corresponding hub is shared between system partitions.
+
+		The this_partition entry contains a boolean value describing whether
+		the corresponding hub is local to the current partition.
+
+		Each hub object directory also contains a number of port objects,
+		each representing a fabric port on the corresponding hub.
+		A port object's name is appended by a unique ordinal value
+		(ex. /sys/firmware/sgi_uv/hubs/hub_5/port_3)
+
+		Each port object directory contains a number of read-only attributes:
+
+			conn_hub
+			conn_port
+
+		The conn_hub entry contains a value representing the unique
+		oridinal value of the hub on the other end of the fabric
+		cable plugged into the port. If the port is disconnected,
+		the value returned will be -1.
+
+		The conn_port entry contains a value representing the unique
+		oridinal value of the port on the other end of the fabric cable
+		plugged into the port. If the port is disconnected, the value
+		returned will be -1.
+
+		Ex:
+			A value of '3' is read from:
+				/sys/firmware/sgi_uv/hubs/hub_5/port_3/conn_hub
+
+			and a value of '6' is read from:
+				/sys/firmware/sgi_uv/hubs/hub_5/port_3/conn_port
+
+			representing that this port is connected to:
+			/sys/firmware/sgi_uv/hubs/hub_3/port_6
+
+
+		The pcibuses directory contains a number of PCI bus objects.
+		Each PCI bus object's name is appended by its PCI bus address.
+		(ex. pcibus_0003:80)
+
+		Each pcibus object has a number of possible read-only attributes:
+
+			type
+			location
+			slot
+			ppb_addr
+			iio_stack
+
+		The type entry contains a value describing the type of IO at
+		the corresponding PCI bus address. Known possible values
+		across all UV versions are:
+			BASE IO
+			PCIe IO
+			PCIe SLOT
+			NODE IO
+			Riser
+			PPB
+
+		The location entry contains the location string of the UV Hub
+		of the CPU physically connected to the corresponding PCI bus.
+
+		The slot entry contains the physical slot number of the
+		corresponding PCI bus. This value is used to physically locate
+		PCI cards within a system.
+
+		The ppb_addr entry contains the PCI address string of the
+		bridged PCI bus. This entry is only present when the PCI bus
+		object type is 'PPB'.
 
-			cat /sys/firmware/sgi_uv/coherence_id
+		The iio_stack entry contains a value describing the IIO stack
+		number that the corresponding PCI bus object is connected to.
