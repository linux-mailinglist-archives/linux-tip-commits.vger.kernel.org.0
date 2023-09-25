Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E21F7ADB1B
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Sep 2023 17:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbjIYPOg (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 25 Sep 2023 11:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232556AbjIYPOg (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 25 Sep 2023 11:14:36 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199B310A
        for <linux-tip-commits@vger.kernel.org>; Mon, 25 Sep 2023 08:14:29 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id ada2fe7eead31-45260b91a29so2935853137.2
        for <linux-tip-commits@vger.kernel.org>; Mon, 25 Sep 2023 08:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=happybizdata-com.20230601.gappssmtp.com; s=20230601; t=1695654868; x=1696259668; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BtNfrxgf4X+cTsDMONzKl75qRElkb7tAwQe0Ph+Ar2Q=;
        b=j4+1lOKQ75Eteyh3mYqAyulI5GJlyRFQpsBL2yBKWMLLGcf7Nb/I7hdZsguNApdfDt
         rqeZSBiexuk1yh83iBi+uNIsWm0MZ763QD5dQgOMttnfNsxdbVv++xlQyitQXpdiN/p7
         Dc5yozavczGK0Gl0GkFK1iFKMzXCKLqzINCixYXmCdv8R6fdILdfGcoNCxJpIzhDpo2Z
         AUtBUsgjzCu11bNqil8hpXgEFGmSYx56yz5mRltmJBAMvpe8DZZWaLy/2AXEepBtZ24S
         71KB4AI3pTR6oZZ3r7tiNd/ODzvNAzaaHF4yZbPbjNVUH9WwrQC8VMcDsGBzEabFZsAw
         zmDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695654868; x=1696259668;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BtNfrxgf4X+cTsDMONzKl75qRElkb7tAwQe0Ph+Ar2Q=;
        b=NxHJfYpZjX2irGbDP5Sf4uDz6yoQSqoTvEE99GPJ3JFw84tOSwLQyjxZuvoovF7Tdt
         7pjAqHmRUDkkgkY3ZO7xKy/EhuWsUgrMfUbMii2iDrs4alhAEUKHKVYabNJvm7R63Iv3
         BCOhszKmaGa/eYlr+8mOUAcmbiX/mufkjxPvwMikD01bdAe+1Z0rsjhYH39mmfB5SFkc
         Pk9tC3l8ax29noBPvkiUcf7rTYnmTp8pGLWr4krm+4hdn4JFUXp2+CBwcPDUmHHZdxb+
         DCtRaBgHhCUtcnunuzehrNNWg+NaxKEcEDKna10px6ihD4+LkCV3EE3OEVd18Zduoy9g
         XXxQ==
X-Gm-Message-State: AOJu0Yw2YnoVHTNjksSdi3vbXFE0SSHsA5+dAB4sl9sAB0u7KO9K2YWc
        x05+ENBY1GMC522fV//hK6ngIz2lTIJddwv1JaL2cQ==
X-Google-Smtp-Source: AGHT+IExQPiZeST6UBNLhESqww9YHARUad58911NAde7hcBWx2F6ERBPJHqYcyUSazR13vV6oN3kFh0eB9Fgb/bu72c=
X-Received: by 2002:a67:f842:0:b0:452:5c6d:78c9 with SMTP id
 b2-20020a67f842000000b004525c6d78c9mr4218569vsp.12.1695654868281; Mon, 25 Sep
 2023 08:14:28 -0700 (PDT)
MIME-Version: 1.0
From:   Sofia Gonzales <sofia@happybizdata.com>
Date:   Mon, 25 Sep 2023 10:14:15 -0500
Message-ID: <CAMh3ZMJ_yEt0YCimcbJ+BwwJSX+PGktO6dGS1gmSQ1snAUqVpg@mail.gmail.com>
Subject: RE: HIMSS Global Health Conference Email List 2023
To:     Sofia Gonzales <sofia@happybizdata.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

Hi,

Would you be interested in acquiring the Healthcare Information and
Management Systems Society Email List?

Number of Contacts: 45,486
Cost: $1,918

Interested? Email me back; I would love to provide more information on the list.

Kind Regards,
Sofia Gonzales
Marketing Coordinator
