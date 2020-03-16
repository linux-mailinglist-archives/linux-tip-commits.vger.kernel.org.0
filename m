Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2DEB186CF3
	for <lists+linux-tip-commits@lfdr.de>; Mon, 16 Mar 2020 15:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731144AbgCPOVw (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 16 Mar 2020 10:21:52 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35086 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729631AbgCPOVw (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 16 Mar 2020 10:21:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584368511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EPguWxlAycQreH6hAzLD5QV1HYeo+0AK3EDG3x5x0Gw=;
        b=N0S1YyjlXr5LB7YVILRBy20UbotGBIe+7WbUnxWl8UjpWFvNxVocNfM5RcQjmT1pQAD9Fm
        5m5f4axkAyj+8JdcGO9+AYn5pOzihFsSCZHe+KmIlGGhHCCzye+g8vWu+2fT1fC9qrkX0v
        lM/yopXni6vrJo9aq9jNLmcUGclUPWA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-JEb70QG1NZGdbhjOl0GXXQ-1; Mon, 16 Mar 2020 10:21:36 -0400
X-MC-Unique: JEb70QG1NZGdbhjOl0GXXQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9516F800D5C;
        Mon, 16 Mar 2020 14:21:35 +0000 (UTC)
Received: from rules.brq.redhat.com (ovpn-205-7.brq.redhat.com [10.40.205.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2C0485C1B5;
        Mon, 16 Mar 2020 14:21:29 +0000 (UTC)
From:   Vladis Dronov <vdronov@redhat.com>
To:     Sasha Levin <sashal@kernel.org>, linux-tip-commits@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [tip: efi/urgent] efi: Add a sanity check to efivar_store_raw()
Date:   Mon, 16 Mar 2020 15:21:13 +0100
Message-Id: <20200316142113.11992-1-vdronov@redhat.com>
In-Reply-To: <20200309122504.3DA3A20848@mail.kernel.org>
References: <20200309122504.3DA3A20848@mail.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

Backported:
https://lore.kernel.org/stable/20200316131938.31453-1-vdronov@redhat.com/=
T/#u

Best regards,
Vladis Dronov | Red Hat, Inc. | The Core Kernel | Senior Software Enginee=
r

